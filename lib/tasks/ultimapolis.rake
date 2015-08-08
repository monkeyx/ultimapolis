namespace :ultimapolis do
	task :generate_events => :environment do
		EventTypes.generate_crisis! unless Event.current_crisis
		EventTypes.generate_opportunity! unless Event.current_opportunity
	end
end