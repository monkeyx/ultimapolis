module ExchangeItem
	extend ActiveSupport::Concern

	included do 
		before_save :calculate_exchange_price
	end 

	def exchange_class
		raise "Exchange class is not set"
	end

	def exchanges(turn)
		exchange_class.for_item(self).for_turn(turn)
	end

	def base_price
		(self.facility_type.maintenance_cost * 1.25).round(0).to_i + raw_materials_price
	end

	def raw_materials_price
		return 0 if raw_materials.empty?
		raw_materials.to_a.sum do |rm|
			(rm.raw_material.exchange_price == 0 ? rm.raw_material.base_price : rm.raw_material.exchange_price) * rm.quantity
		end
	end

	def exchange_demand(turn=(Global.singleton.turn-1))
		buys = 0
		sells = 0
		exchanges(turn).each do |exchange|
			if exchange.quantity > 0
				buys += exchange.quantity
			elsif exchange.quantity < 0
				sells += exchange.quantity.abs
			end
		end
		if buys > sells
			if sells == 0
				return 4
			else
				return 1 * (sells.to_f / buys.to_f)
			end
		elsif buys < sells
			if buys == 0
				return 0.25
			else
				return 1 * (buys.to_f / sells.to_f)
			end
		else
			1
		end
	end

	def calculate_exchange_price
		self.exchange_price = (base_price * exchange_demand * (1 + Global.singleton.inflation.to_f / 100.0)).round(0).to_i
	end
end