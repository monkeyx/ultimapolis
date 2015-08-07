module ApplicationHelper
	def current_citizen
		@current_citizen ||= (current_user && current_user.citizen)
	end

	def current_citizen_path
		@current_citizen_path ||= if current_citizen
			citizen_path(current_citizen)
		else
			root_url
		end
	end
end
