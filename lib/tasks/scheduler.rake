desc "Turn processor"
task :next_turn => :environment do
  TurnEngine.delay.turn!
end