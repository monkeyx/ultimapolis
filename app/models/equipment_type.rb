class EquipmentType < ActiveRecord::Base
	
	validates :name, presence: true
	belongs_to :facility_type
	# t.text :description
	# t.string :icon
	belongs_to :skill 
	validates :skill_modifier, numericality: {only_integer: true}
	validates :exchange_price, numericality: {only_integer: true}
	validates :for_sale, numericality: {only_integer: true}
	
	has_many :equipment_raw_materials

	scope :named, ->(name) {where(name: name)}
	scope :for_facility_type, ->(facility_type) { where(facility_type_id: facility_type.id )}
	scope :for_skill, ->(skill) { where(skill_id: skill.id )}
	default_scope ->{ order('name ASC') }

	def self.create_new!(name, description, facility_type, skill, modifier, raw_materials=[])
		et = create!(
			name: name,
			description: description,
			skill: skill,
			skill_modifier: modifier,
			facility_type: facility_type
		)

		raw_materials.each do |raw_material|
			et.equipment_raw_materials.create!(trade_good: raw_material[0], quantity: raw_material[1])
		end

		et
	end

	def to_s
		name
	end
end
