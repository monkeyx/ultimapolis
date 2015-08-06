class EventResourceCost < ActiveRecord::Base
# t.integer :event_id
# t.integer :trade_good_id
# t.integer :cost
	
	belongs_to :event
	belongs_to :trade_good
	validates :cost, numericality: {only_integer: true}
end
