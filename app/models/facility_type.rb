class FacilityType < ActiveRecord::Base

	validates :name, presence: true
	validates :name, length: {in: 3..255 }
	belongs_to :district
	# t.text :description
	# t.string :icon
	validates :build_cost, numericality: {only_integer: true}
	validates :maintenance_cost, numericality: {only_integer: true}
	validates :employees, numericality: {only_integer: true}
	validates :automation, numericality: {only_integer: true}
	validates :power_consumption, numericality: {only_integer: true}
	validates :power_generation, numericality: {only_integer: true}
	validates :pollution, numericality: {only_integer: true}
	validates :housing_mod, numericality: {only_integer: true}
	
	has_many :equipment_types
	has_many :trade_goods
	has_many :facilities, dependent: :delete_all

	scope :named, ->(name) {where(name: name)}
	scope :for_district, ->(district) { where(district_id: district.id ) }
	scope :in_districts, ->(districts) { where(["district_id in (?)", [0] + districts.map{|d| d.id }])}
	scope :buildable, -> { where(["district_id in (?)", [0] + District.has_free_land.select{|d| d.land_cost > 0 }.map{|d| d.id}]) }
	scope :build_cost_less_or_equal_to, ->(credits) { where(["build_cost <= ?", credits])}
	scope :power_generator, -> { where("power_generation > 0")}
	scope :power_consumer, -> { where("power_consumption > 0")}
	scope :housing, -> { where("housing_mod > 0")}

	default_scope ->{ order('name ASC') }

	acts_as_commontable

	def self.create_new!(name, description, district, options={})
		options = {
			name: name,
			description: description,
			icon: "/icons/facility_types/#{name.gsub(' ', '_').downcase}.png",
			district: district,
			build_cost: 1000,
			maintenance_cost: 100,
			employees: 10,
			automation: 50,
			power_consumption: 1,
			power_generation: 0,
			pollution: 0,
			housing_mod: 0
		}.merge!(options)

		create!(options)
	end

	def self.buildable_and_affordable(credits)
		FacilityType.buildable.build_cost_less_or_equal_to(credits).select{|ft| credits >= (ft.build_cost + ft.district.land_cost)}
	end

	def rent_income
		@rent_income ||= (Global.singleton.rent_income * self.housing_mod)
	end

	def power_generation_income
		@power_generation_income ||= (Global.singleton.power_generation_income * self.power_generation)
	end

	def defaultable_trade_goods
		@defaultable_trade_goods ||= trade_goods.select{|tg| tg.no_raw_materials? }
	end

	def to_s
		name
	end

	def count
		@count ||= facilities.count
	end

	def produceable
		return @produceable if defined?(@produceable)
		@producable = trade_goods.to_a + equipment_types.to_a
		@producable.sort!{|a, b| a.name <=> b.name }
		@producable
	end
end
