module Robot
  class Play
    attr_accessor :table
    VALID_COMMANDS   = ["RIGHT", "LEFT", "MOVE", "REPORT"]
    VALID_DIRECTIONS = ["NORTH", "SOUTH", "EAST", "WEST"]
    VALID_COORDS = ["1", "2", "3", "4", "5"]

    def initialize(options={})
      @table = options[:table] || Robot::Board.new
    end

    def get_move(human_move = gets.chomp)
    end

    def is_valid_command?(command)
      VALID_COMMANDS.each {|c| return true if c == command}
      validate_place_command(command)
      false
    end

    def validate_place_command(command)
      # all this code could be done with a regex but in that way
      # we can manage way more exceptions and see where the user fails (in the future)
      return false if !command.include?("PLACE")
      coords = command.gsub!("PLACE", "").strip.split(",")
      return false if coords.size > 3
      return false unless to_number(coords[0]) or to_number(coords[1])
      return is_valid_direction?(coords[2])
      false
    end

    def is_valid_direction?(direction)
      VALID_DIRECTIONS.each {|d| return true if d == direction}
      false
    end

    def to_number(str)
      str.to_i if str[/^-?\d+$/] and str.size == 1
    end

  end
end