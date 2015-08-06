class EquipmentRawMaterial < ActiveRecord::Base
# t.integer :equipment_type_id
# t.integer :trade_good_id
# t.integer :quantity

	belongs_to :equipment_type
	belongs_to :trade_good
	validates :quantity, numericality: {only_integer: true}
end
