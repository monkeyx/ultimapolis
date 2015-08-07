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

    validate :validate_facility

    before_save :deduct_costs!

    scope :for_citizen, ->(citizen) { where(citizen_id: citizen.id )}
    scope :for_facility_type, ->(facility_type) { where(facility_type_id: facility_type.id )}

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

    def to_s
        "#{facility_type && facility_type.name} \##{id}"
    end

    def build_cost
        @build_cost ||= (facility_type.build_cost + facility_type.district.land_cost)
    end

    def upgrade_cost(levels=1)
        facility_type.build_cost * levels
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
                    errors.add(:facility_type, "is too expensive to build")
                end
            else
                if level_changed? && citizen.credits < upgrade_cost(level - level_was)
                    errors.add(:level, "is too expensive to upgrade")
                end
            end
        end
    end

    def deduct_costs!
        Kernel.p "BUILD COST: #{build_cost} FREE? #{build_for_free}"
        return if build_for_free
        if new_record?
            citizen.credits -= build_cost
            citizen.save!
        elsif level_changed?
            citizen.credits -= upgrade_cost(level - level_was)
            citizen.save!
        end
    end
end
