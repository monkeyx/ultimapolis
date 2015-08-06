class Facility < ActiveRecord::Base

	belongs_to :citizen
	belongs_to :facility_type
	# t.boolean :powered
	# t.boolean :maintained
	validates :level, numericality: {only_integer: true}
	belongs_to :producing_trade_good, class_name: 'TradeGood'
    belongs_to :producing_equipment_type, class_name: 'EquipmentType'
	

end
