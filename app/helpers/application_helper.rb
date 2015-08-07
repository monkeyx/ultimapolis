module ApplicationHelper
	def current_citizen
		@current_citizen ||= (current_user && current_user.citizen)
	end
end
