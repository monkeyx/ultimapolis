class TradeGoodRawMaterial < ActiveRecord::Base

	belongs_to :trade_good
	belongs_to :raw_material, class_name: 'TradeGood'
	validates :quantity, numericality: {only_integer: true}
end
