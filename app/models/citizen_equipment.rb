class CitizenEquipment < ActiveRecord::Base
# t.integer :citizen_id
# t.integer :equipment_type_id
# t.integer :quantity
	
	belongs_to :citizen
	belongs_to :equipment_type
	validates :quantity, numericality: {only_integer: true}
end
