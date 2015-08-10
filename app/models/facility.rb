class Facility < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :facility_type
    validates :citizen_id, presence: true
    validates :facility_type_id, presence: true
	# t.boolean :powered
	# t.boolean :maintained
	validates :level, numericality: {only_integer: true}
	belongs_to :producing_trade_good, class_name: 'TradeGood'
    belongs_to :producing_equipment_type, class_name: 'EquipmentType'

    attr_accessor :levels

    validate :validate_facility

    before_validation :increase_levels
    before_save :choose_default_producing
    before_save :deduct_costs!
    after_destroy :recoup_value!
    after_create :use_free_land!
    
    scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
    scope :with_facility_types, ->(facility_types) { where(["facility_type_id in (?)", [0] + facility_types.map{|ft| ft.id }])}
    scope :for_facility_type, ->(facility_type) { where(facility_type_id: facility_type.id )}
    scope :for_district, ->(district) { with_facility_types(FacilityType.for_district(district)) }
    scope :powered, -> { where(powered: true )}
    scope :maintained, -> { where(maintained: true )}

    default_scope ->{ includes(:facility_type).order('facility_types.name ASC') }

    attr_accessor :build_for_free
	
    def self.create_new!(citizen, facility_type, build_for_free=false)
    	create!(
    		citizen: citizen,
    		facility_type: facility_type,
    		powered: true,
    		maintained: true,
    		level: 1,
            build_for_free: build_for_free
    	)
    end

    def quantity_trade_good_produced
        return 0 unless self.powered && self.maintained
        @quantity_trade_good_produced ||= if self.producing_trade_good
            self.citizen.max_trade_good_produced(producing_trade_good)
        else
            0
        end
        @quantity_trade_good_produced < 0 ? self.level : @quantity_trade_good_produced
    end

    def quantity_equipment_produced
        return 0 unless self.powered && self.maintained
        @quantity_equipment_produced ||= if self.producing_equipment_type
            self.citizen.max_equipment_produced(producing_equipment_type)
        else
            0
        end
        @quantity_equipment_produced < 0 ? self.level : @quantity_equipment_produced
    end

    def gdp_contribution
        gdp = 0
        gdp += power_generation_income
        gdp += rent_income
        gdp += (self.producing_trade_good.exchange_price * quantity_trade_good_produced) if self.producing_trade_good && self.producing_trade_good.exchange_price && quantity_trade_good_produced
        gdp += (self.producing_equipment_type.exchange_price * quantity_equipment_produced) if self.producing_equipment_type && self.producing_equipment_type.exchange_price && quantity_equipment_produced
        gdp
    end

    def rent_income
        @rent_income ||= self.facility_type.rent_income * self.level
    end

    def housing_mod
        @housing_mod ||= self.facility_type.housing_mod * self.level
    end

    def power_generation_income
        @power_generation_income ||= self.facility_type.power_generation_income * self.level
    end

    def value
        return @total_value if defined?(@total_value)
        @total_value = build_cost
        self.level.times do |n|
            @total_value += upgrade_cost(1, n)
        end
        @total_value
    end

    def producer?
        @is_producer ||= facility_type && facility_type.produceable.count > 0
    end

    def to_s
        "#{facility_type && facility_type.name} \##{id}"
    end

    def maintenance_cost
        @maintenance_cost ||= (facility_type.maintenance_cost * self.level)
    end

    def build_cost
        @build_cost ||= (facility_type.build_cost + facility_type.district.land_cost)
    end

    def upgrade_cost(levels=1, from_level=self.level)
        cost = 0
        target_level = from_level + levels
        level = from_level
        while level < target_level do 
            cost += (facility_type.build_cost * level)
            level += 1
        end 
        cost
    end

    def validate_facility
        unless citizen 
            errors.add(:citizen, "not valid")
        end
        unless facility_type && facility_type.district
            errors.add(:facility_type, "not valid")
        end
        return if errors.count > 0
        unless facility_type.district.land_cost > 0
            errors.add(:facility_type, "doesn't have sufficient land in #{facility_type.district} to build")
        end
        unless build_for_free
            if new_record?
                if citizen.credits < build_cost
                    errors.add(:facility_type, "is too expensive to build (need #{build_cost} credits)")
                end
            else
                if level_changed? && citizen.credits < upgrade_cost(level - level_was, level_was)
                    errors.add(:level, "is too expensive to upgrade to #{level} (need #{upgrade_cost((level - level_was), level_was)} credits)")
                    self.level = level_was
                end
            end
        end
    end

    def increase_levels
        if self.levels
            self.level += levels.to_i
        end
    end

    def choose_default_producing
        if new_record? && facility_type && facility_type.defaultable_trade_goods.count > 0
            self.producing_trade_good = facility_type.defaultable_trade_goods.to_a.sample
        end
    end

    def deduct_costs!
        return if build_for_free
        if new_record?
            self.citizen.remove_credits!(build_cost, "Built #{self.facility_type}")
            self.citizen.add_report!("Built #{self.facility_type}")
        elsif level_changed? && (diff = (level - level_was)) > 0
            self.citizen.remove_credits!(upgrade_cost(diff, level_was), "Upgraded #{self}")
            self.citizen.add_report!("Upgraded #{self}")
        end
    end

    def recoup_value!
        self.citizen.add_credits!(value, "Sold #{self}")
        self.citizen.add_report!("Sold #{self}")
    end

    def use_free_land!
        self.facility_type.district.update_attributes!(free_land: self.facility_type.district.free_land - 1)
    end

    def turn_update!
        transaction do
            if self.citizen.credits < maintenance_cost
                self.maintained = false
            else
                self.maintained = true
                self.citizen.remove_credits!(maintenance_cost, "Maintain #{self}")
            end
            self.powered = Global.singleton.powered_chance == 100 ? true : rand(100) < Global.singleton.powered_chance
            save!

            if self.powered && self.maintained
                self.citizen.add_credits!(rent_income,"Rent from #{self}") if rent_income
                self.citizen.add_credits!(power_generation_income, "Power sales from #{self}") if power_generation_income
                if quantity_trade_good_produced && quantity_trade_good_produced > 0
                    self.citizen.add_trade_good!(self.producing_trade_good, quantity_trade_good_produced)
                end
                if quantity_equipment_produced && quantity_equipment_produced > 0
                    self.citizen.add_equipment!(self.producing_equipment_type, quantity_equipment_produced)
                end
            end
            self.citizen.save!
        end
    end
end
