class CitizenTradeGood < ActiveRecord::Base
# t.integer :citizen_id
# t.integer :trade_good_id
# t.integer :quantity

	belongs_to :citizen
	belongs_to :trade_good 
	validates :quantity, numericality: {only_integer: true}
end
