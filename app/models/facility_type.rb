class FacilityType < ActiveRecord::Base

	validates :name, presence: true
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
	has_many :facilities

	scope :for_district, ->(district) { where(district_id: district.id )}

	default_scope ->{ order('name ASC') }

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

	def count
		@count ||= facilities.count
	end
end
