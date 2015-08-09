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
		if n.nil? || n < 0
			"Never"
		else
			y = 2300 + (n / 12).to_i
			s = case (n % 12)
			when 0
				"Undember"
			when 1
				"Duodember"
			when 2
				"Primember"
			when 3
				"Secundember"
			when 4
				"Tertember"
			when 5
				"Quartember"
			when 6
				"Quintember"
			when 7
				"Sextember"
			when 8
				"September"
			when 9
				"October"
			when 10
				"November"
			when 11
				"December"
			end
			"#{s} #{y} CE"
		end
	end
end