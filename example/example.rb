require_relative "../lib/robot.rb"

puts "Welcome to Robot"

player = Roboruby::Play.new

puts "\n >> PLEASE USE THE VALID COMMANDS << \n\n"
puts "\n ==> RIGHT, LEFT, MOVE, REPORT, PLACE \n\n"

loop do
  puts "\n\n\n => Type a new command:"
  puts player.get_move(gets.chomp)
end
