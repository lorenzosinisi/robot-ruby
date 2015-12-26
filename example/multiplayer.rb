require_relative "../lib/robot.rb"

puts "Welcome to Roboruby!"

puts "What is the name of the first player?"
first_player_name = gets.chomp
puts "great #{first_player_name} :D welcome!"

puts "What is the name of the second player?"
second_player_name = gets.chomp
puts "great #{second_player_name} :D welcome you too!"

first  = Roboruby::Play.new({name: first_player_name})
second = Roboruby::Play.new({name: second_player_name})

puts "\n >> PLEASE USE THE VALID COMMANDS << \n\n"
puts "\n ==> RIGHT, LEFT, MOVE, REPORT, PLACE \n\n"

loop do

  puts "It's your time #{first.name}! Select your move:"
  first.get_move(gets.chomp)

  puts "It's your time #{second.name}! Select your move:"
  second.get_move(gets.chomp)

end
