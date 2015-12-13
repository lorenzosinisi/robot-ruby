module Robot
  class Play
    attr_accessor :robot, :command_type, :command_x, :command_y, :command_f
    VALID_COMMANDS   = %w(RIGHT LEFT MOVE REPORT PLACE)
    VALID_DIRECTIONS = %w(NORTH SOUTH EAST WEST)

    def initialize(options={})
      @robot = options[:robot] || Robot::Board.new
      @command_x, @command_y, @command_f = 0,0,"NORTH"
    end

    def start
      puts valid_commands
      while true
        if get_move(gets.chomp)
          puts "\n\n\n\n\n\n"
          puts "=> Type a new command:"
          puts "\n\n"
        else
          puts "\n\n\n\n\n\n"
          puts "=> Invalid command"
          puts valid_commands
          puts self.inspect
          puts "=> Type a new command:"
        end
      end
    end

    def valid_commands
      puts "Valid commands: RIGHT, LEFT, MOVE, REPORT, PLACE X, Y, F"
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

    def human_command_to_robot
      case self.command_type
        when :right
          @robot.move_right
        when :left
          @robot.move_left
        when :move
          @robot.move
        when :report
          puts @robot.report
        when :place
          @robot.set_cell(command_x, command_y, command_f)
        else
          nil
      end
    end

    def parse_command(cmd)
      command = cmd.split(" ")
      type = command[0]
      args = command[1]
      if is_valid_command?(type) and args
        self.command_type = type.downcase.to_sym
        extract_arguments(args)
      elsif is_valid_command?(type)
        self.command_type = type.downcase.to_sym
      else
        self.command_type = nil
      end
    end

    def extract_arguments(args)
      arguments = args.split(",")
      if VALID_DIRECTIONS.include?(arguments[2])
        self.command_x = Integer(arguments[0])
        self.command_y = Integer(arguments[1])
        self.command_f = arguments[2]
      else
        puts "Not a valid direction: #{arguments[2]}. Valid directions #{VALID_DIRECTIONS}"
      end
    end

    def is_valid_command?(type)
      type = type.split(" ")[0]
      if VALID_COMMANDS.include?(type)
        true
      else
         puts "Not a valid command #{type}. #{valid_commands}"
         false
      end
    end

  end
end
