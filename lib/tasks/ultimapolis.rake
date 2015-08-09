namespace :ultimapolis do
	task :turn => :environment do
		TurnEngine.turn!
	end
end