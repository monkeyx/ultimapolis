class EventResourceCost < ActiveRecord::Base
	belongs_to :event
	belongs_to :trade_good
	validates :cost, numericality: {only_integer: true}
end
