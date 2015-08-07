module NumberHelper

	def format_number(n)
		number_with_delimiter(n)
	end

	def format_currency(n)
		"&cent; #{number_with_delimiter(n)}".html_safe
	end

	def format_turn(n)
		if n < 0
			"Never"
		else
			"Turn #{n}"
		end
	end
end