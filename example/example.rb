require_relative "../lib/robot.rb"

puts "Welcome to Robot"

player = Robot::Play.new

puts "\n >> PLEASE SEE THE POSITIONS OF THE BOARD << \n\n"

puts player.start
