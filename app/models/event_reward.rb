class EventReward < ActiveRecord::Base
# t.integer :event_id
# t.integer :trade_good_id
# t.integer :equipment_type_id
# t.integer :facility_id
# t.boolean :credits, default: false
# t.integer :quantity

	belongs_to :event
	belongs_to :trade_good
	belongs_to :equipment_type
	belongs_to :facility
	validates :quantity, numericality: {only_integer: true}
end
