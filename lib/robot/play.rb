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
      show_welcome_message
      loop do
        if it_can_execute(gets.chomp) # get the user input here <<<<
          # great!
        else
          show_error
        end
        solicit_new_command
      end
    end

    def get_move(move)
      if is_valid_command?(move)
        parse_command!(move)
        send_command_to_robot!
        true
      else
        false
      end
    end

    alias_method :it_can_execute, :get_move

    def send_command_to_robot!
      case command_type
        when :right, :left, :move, :report
          robot.send(command_type)
        when :place
          robot.place(command_x, command_y, command_f)
        else
          puts "Not a valid command #{command_type}"
      end
    end

    def parse_command!(cmd)
      command = cmd.split(" ")
      type, args = command[0], command[1]
      extract_arguments!(args) if args
    end

    def extract_arguments!(args)
      args = args.split(",")
      x, y, f = args[0], args[1], args[2]
      if valid_coords?(x,y) and valid_direction?(f)
        self.command_x = x.to_i
        self.command_y = y.to_i
        self.command_f = f
      end
    end

    def is_valid_command?(type)
      type = type.split(" ")[0]
      if VALID_COMMANDS.include?(type)
        self.command_type = type.downcase.to_sym
        true
      else
         puts "Not a valid command #{type}. #{valid_commands}"
      end
    end

    def valid_coords?(x,y)
      begin
        Integer(x) and Integer(y)
      rescue => e
        puts e
        false
      end
    end

    def valid_direction?(d)
      return true if VALID_DIRECTIONS.include?(d)
      puts "Not a valid direction: '#{arguments[2]}'. Valid directions #{VALID_DIRECTIONS}"
    end

    # Messages for the user
    
    def show_welcome_message
      puts valid_commands
      solicit_new_command
    end

    def valid_commands
      "Valid commands: #{VALID_COMMANDS}"
    end

    def solicit_new_command
      puts "\n\n\n"
      puts "=> Type a new command:"
    end

    def show_error
      puts "=> Invalid command!"
    end

  end
end
