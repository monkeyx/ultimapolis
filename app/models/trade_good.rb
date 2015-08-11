class TradeGood < ActiveRecord::Base
	include ExchangeItem

	validates :name, presence: true
	belongs_to :facility_type
	validates :exchange_price, numericality: {only_integer: true}
	# t.text :description
	# t.string :icon

	has_many :trade_good_raw_materials, dependent: :delete_all

	scope :named, ->(name) {where(name: name)}

	default_scope ->{ order('name ASC') }

	acts_as_commontable

	alias_method :raw_materials, :trade_good_raw_materials
	
	def self.create_new!(name, description, facility_type, raw_materials=[])
		tg = create!(
			name: name,
			description: description,
			icon: "/icons/trade_goods/#{name.gsub(' ', '_').downcase}.png",
			facility_type: facility_type
		)

		raw_materials.each do |raw_material|
			tg.trade_good_raw_materials.create!(raw_material: raw_material[0], quantity: raw_material[1])
		end

		tg
	end

	def no_raw_materials?
		@no_raw_materials ||= trade_good_raw_materials.count < 1
	end

	def to_s
		name
	end

	def name_with_price
		"#{name} (#{exchange_price} credits)"
	end

	def exchange_class
		ExchangeTradeGood
	end
end
