module TimerHelper
	def next_turn_time
		now = Time.now.utc 
		d = now.day 
		TURN_HOURS.each do |turn_hour|
			next_time = Time.parse("#{now.year}-#{now.month}-#{d} #{turn_hour}:00:00 UTC")
			if next_time > now 
				return next_time
			end
		end
		Time.parse("#{now.year}-#{now.month}-#{(d+1)} 00:00:00 UTC")
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
		elsif minutes.to_i < 1 && seconds.to_i < 1
			"has past. Please refresh."
		else
			"for another #{minutes}:#{seconds} minutes"
		end
	end
end