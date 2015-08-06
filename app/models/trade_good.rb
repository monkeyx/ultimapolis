class TradeGood < ActiveRecord::Base
# t.string :name
# t.integer :facility_type_id
# t.integer :exchange_price
# t.integer :total
# t.integer :produced_last_turn
# t.integer :for_sale
# t.text :description
# t.string :icon

	validates :name, presence: true
	belongs_to :facility_type
	validates :exchange_price, numericality: {only_integer: true}
	validates :total, numericality: {only_integer: true}
	validates :produced_last_turn, numericality: {only_integer: true}
	
	

end
