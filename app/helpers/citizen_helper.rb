module CitizenHelper
	def current_citizen
		@current_citizen ||= (current_user && current_user.citizen)
	end

	def current_citizen_path(tab='profile')
		@current_citizen_path ||= if current_citizen
			"#{citizen_path(current_citizen)}?tab=#{tab}"
		else
			root_url
		end
	end
end