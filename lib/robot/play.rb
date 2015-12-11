module Robot
  class Play
    attr_accessor :table, :command_type
    VALID_COMMANDS   = ["RIGHT", "LEFT", "MOVE", "REPORT"]
    VALID_DIRECTIONS = ["NORTH", "SOUTH", "EAST", "WEST"]
    VALID_COORDS     = ["1", "2", "3", "4", "5"]

    def initialize(options={})
      @table = options[:table] || Robot::Board.new
    end

    def get_move(human_move = gets.chomp)
      if is_valid_command?(human_move)
        human_command_to_robot(human_move)
      else
        try_again_no_valid_command
      end
    end

    def human_command_to_robot(cmd)
      if command_type == :simple_command
        case cmd
          when "RIGHT"
            @table.move_right
          when "LEFT"
            @table.move_left
          when "MOVE"
            # not implemented yet
          when "REPORT"
            # not implemented yet
        end
      else
        send_place_command
      end
    end

    def try_again_no_valid_command
      "Sorry, try again"
    end
    
    def send_place_command
      @table.set_cell(@coords[0].to_i, @coords[1].to_i, @direction)
    end

    def is_valid_command?(command)
      VALID_COMMANDS.each {|c| self.command_type = :simple_command and return true if c == command}
      return validate_place_command(command)
    end
    
    def validate_place_command(command)
      # all this code could be done with a regex but in that way
      # we can manage way more exceptions and see where the user fails (in the future)
      return false if !command.include?("PLACE")
      @coords = command.gsub!("PLACE", "").strip.split(",")
      return false if @coords.size > 3
      return false unless to_number(@coords[0]) or to_number(@coords[1])
      return is_valid_direction?(@coords[2])
      false
    end

    # assign the direction to the variable in case the direction is valid
    def is_valid_direction?(direction)
      VALID_DIRECTIONS.each {|d| @direction = direction and return true if d == direction}
      false
    end

    # check that the string is a number
    def to_number(str)
      str.to_i if str[/^-?\d+$/] and str.size == 1
    end

  end
end