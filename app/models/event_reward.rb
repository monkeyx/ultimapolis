class EventReward < ActiveRecord::Base

	belongs_to :event
	belongs_to :trade_good
	belongs_to :equipment_type
	belongs_to :facility_type
	# t.boolean :credits, default: false
	validates :quantity, numericality: {only_integer: true}

	def to_s
		if trade_good
			"#{quantity} x #{trade_good}"
		elsif equipment_type
			"#{equipment_type}"
		elsif facility_type
			"#{facility_type}"
		elsif credits
			"&cent; #{quantity}"
		end
	end
end
