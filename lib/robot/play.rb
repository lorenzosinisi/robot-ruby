module Robot
  class Play
    # the plan where the Robot can move
    attr_accessor :table

    # valid simple commands ready to be executed
    VALID_COMMANDS   = ["RIGHT", "LEFT", "MOVE", "REPORT"]

    # valid directions that the robot can get
    VALID_DIRECTIONS = ["NORTH", "SOUTH", "EAST", "WEST"]

    def initialize(options={})
      @table = options[:table] || Robot::Board.new
    end


    def start
      while true
        if get_move(cmd = gets.chomp)
          puts cmd
          puts "\n\n\n\n\n\n"
          puts "=> Type a new command:"
          puts "\n\n"
        else
          puts "\n\n\n\n\n\n"
          puts "=> Invalid command"
          puts valid_commands
          puts "=> Type a new command:"
        end
      end
    end

    def valid_commands
      puts "Valid commands: RIGHT, LEFT, MOVE, REPORT, PLACE X, Y, F"
    end

    def get_move(human_move)
      if is_valid_command?(human_move)
        human_command_to_robot(human_move)
        true
      else
        try_again_no_valid_command
        return false
      end
    end

    def human_command_to_robot(cmd)
      case cmd
        when "RIGHT"
          @table.move_right
        when "LEFT"
          @table.move_left
        when "MOVE"
          @table.move
        when "REPORT"
          puts "\n\n\n\n\n\n"
          puts @table.report
        else
          send_place_command("PLACE " + cmd)
      end
    end

    def try_again_no_valid_command
      "Sorry, try again"
    end

    def send_place_command(cmd)
      if validate_place_command(cmd)
        @table.set_cell(@coords[0].to_i, @coords[1].to_i, @direction)
      end
    end

    def is_valid_command?(command)
      VALID_COMMANDS.each {|c| return true if c == command}
      validate_place_command(command)
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
