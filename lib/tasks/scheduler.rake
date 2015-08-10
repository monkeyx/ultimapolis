desc "Turn processor"
task :next_turn => :environment do
  TurnEngine.turn!
end