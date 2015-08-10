class TurnEngine

	def self.turn!
		puts ">> ULTIMAPOLIS"
		puts ">>> GLOBAL UPDATES"
		Global.singleton.turn_update!

		puts ">>> DISTRICT UPDATES"
		progressbar = ProgressBar.create(:total => District.count)
		District.all.each do |district|
			district.turn_update!
			progressbar.increment
		end

		puts ">>> FACILITY UPDATES"
		progressbar = ProgressBar.create(:total => Facility.count)
		Facility.find_each do |facility|
			facility.turn_update!
			progressbar.increment
		end

		Event.current.each do |event|
			puts ">>> #{event} UPDATES"
			progressbar = ProgressBar.create(:total => Project.where({event_id: event.id}).count)
			Project.where({event_id: event.id}).find_each do |project|
				project.turn_update!
				progressbar.increment
			end
			event.turn_update!
		end

		puts ">>> LOANS UPDATES"
		progressbar = ProgressBar.create(:total => Loan.count)
		Loan.find_each do |loan|
			loan.turn_update!
			progressbar.increment
		end

		puts ">>> BOND UPDATES"
		progressbar = ProgressBar.create(:total => Bond.count)
		Bond.find_each do |bond|
			bond.turn_update!
			progressbar.increment
		end

		puts ">>> CAREER UPDATES"
		progressbar = ProgressBar.create(:total => CitizenCareer.where({current: true}).count)
		CitizenCareer.where({current: true}).find_each do |career|
			career.turn_update!
			progressbar.increment
		end

		unless Event.current_crisis
			puts ">>> GENERATING CRISIS"
			EventTypes.generate_crisis! 
		end

		unless Event.current_opportunity
			puts ">>> GENERATING OPPORTUNITY"
			EventTypes.generate_opportunity! 
		end

		# TODO Calculate Exchange Prices

		puts ">> TURN COMPLETE"
	end

end