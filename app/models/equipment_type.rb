class EquipmentType < ActiveRecord::Base
# t.string :name
# t.integer :facility_type_id
# t.text :description
# t.string :icon
# t.integer :skill_id
# t.integer :skill_modifier
# t.integer :exchange_price
	
	validates :name, presence: true
	belongs_to :facility_type
	belongs_to :skill 
	validates :skill_modifier, numericality: {only_integer: true}
	validates :exchange_price, numericality: {only_integer: true}
	
	has_many :equipment_raw_materials

	

end
