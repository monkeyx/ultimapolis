module NumberHelper

	def format_rating(n)
		if n.nil? || n < 0
			"N/A"
		else
			"#{n} %"
		end
	end

	def format_number(n)
		number_with_delimiter(n)
	end

	def format_currency(n)
		"&cent; #{number_with_delimiter(n)}".html_safe
	end

	def format_turn(n)
		Global.format_turn(n)
	end
end