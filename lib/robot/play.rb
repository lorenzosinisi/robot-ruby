module Robot
  class Play
    attr_accessor :robot, :command_type, :command_x, :command_y, :command_f
    VALID_COMMANDS   = %w(RIGHT LEFT MOVE REPORT PLACE)
    VALID_DIRECTIONS = %w(NORTH SOUTH EAST WEST)

    def initialize(options={})
      @robot = options[:robot] || Robot::Board.new
      @command_x, @command_y, @command_f = 0, 0, "NORTH"
    end

    def start
      welcome
      while true
        if get_move(gets.chomp) # gets the command from the terminal input and returns true if allowed
          true # everything is fine, next
        else
          show_error
        end
          solicit_command
      end
    end

    def welcome
      puts valid_commands
      solicit_command
    end

    def valid_commands
      "Valid commands: RIGHT, LEFT, MOVE, REPORT, PLACE X, Y, F"
    end

    def solicit_command
      puts "\n\n\n"
      puts "=> Type a new command:"
    end

    def show_error
      puts "=> Invalid command! ERROR: " + @error
    end

    def get_move(human_move)
      if is_valid_command?(human_move)
        parse_command(human_move)
        human_command_to_robot
        true
      else
        false
      end
    end

    # The following can be done in a much nicer way like grouping the move into one single
    # action and sending the direction as parameter but the case statement looks nice as well
    def human_command_to_robot
      case self.command_type
        when :right
          @robot.right
        when :left
          @robot.left
        when :move
          @robot.move
        when :report
          puts @robot.report
        when :place
          @robot.place(command_x, command_y, command_f)
        else
          nil
      end
    end

    # first take the first argument of the command by splitting it by space
    # the first argument should be included in RIGHT LEFT MOVE REPORT PLACE
    # than take the second part of the command and split it by comma to extract x,y and f
    # if the command has arguments than extract them and assign them as a current new state
    def parse_command(cmd)
      command = cmd.split(" ")
      type = command[0]
      args = command[1]
      valid = is_valid_command?(type)
      if valid
        extract_arguments(args) if args
        self.command_type = type.downcase.to_sym
      else
        self.command_type = nil
      end
    end

    # Extract the arguments from the command and make sure that are valid
    # owherwise just save the error in @error variable
    def extract_arguments(args)
      arguments = args.split(",")
      if VALID_DIRECTIONS.include?(arguments[2])
        begin # as Integer() could raise an exception
          self.command_x = Integer(arguments[0])
          self.command_y = Integer(arguments[1])
          self.command_f = arguments[2]
        rescue => e
          @error = e # Save the exception
        end
      else
        @error =  "Not a valid direction: #{arguments[2]}. Valid directions #{VALID_DIRECTIONS}"
      end
    end

    # if the first argument of the command is not permitted than don't even go a step further
    def is_valid_command?(type)
      type = type.split(" ")[0]
      if VALID_COMMANDS.include?(type)
        true
      else
         @error = "Not a valid command #{type}. #{valid_commands}"
         false
      end
    end

  end
end
