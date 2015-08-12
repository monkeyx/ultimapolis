class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	rescue_from CanCan::AccessDenied do |exception|
    	redirect_to main_app.root_path, :alert => exception.message
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
