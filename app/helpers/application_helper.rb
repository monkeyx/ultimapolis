module ApplicationHelper
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

	def next_turn_hour
		h = Time.now.utc.hour 
		m = Time.now.utc.min 
		next_turn_hour = 0
		TURN_HOURS.each do |turn_hour|
			if h < next_turn_hour
				next_turn_hour
			elsif h == turn_hour && m == 0
				turn_hour
			else
				next_turn_hour = turn_hour
			end
		end
		next_turn_hour
	end

	def next_turn_time
		hour = next_turn_hour
		now = Time.now.utc
		time = Time.parse("#{now.year}-#{now.month}-#{now.day} #{hour}:00:00 UTC")
		if hour < Time.now.utc.hour 
			time = time + 1.day
		end
		time
	end

	def seconds_until_next_turn
		seconds = (next_turn_time - Time.now.utc).to_i
	end

	def time_until_next_turn
		seconds = seconds_until_next_turn
		hours = (seconds / 3600).to_i
		seconds -= (hours * 3600)
		minutes = (seconds / 60).to_i
		seconds = seconds % 60
		minutes = "0#{minutes}" if minutes < 10
		seconds = "0#{seconds}" if seconds < 10
		if hours > 0
			"for another #{hours}:#{minutes}:#{seconds} hours"
		elsif minutes < 1 && seconds < 1
			"has past. Please refresh."
		else
			"for another #{minutes}:#{seconds} minutes"
		end
	end
end
