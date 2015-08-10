class EquipmentRawMaterial < ActiveRecord::Base

	belongs_to :equipment_type
	belongs_to :trade_good
	validates :quantity, numericality: {only_integer: true}
end
