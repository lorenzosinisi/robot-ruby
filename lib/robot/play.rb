module Roboruby
  class Play
    attr_accessor :robot, :command, :command_x, :command_y, :command_f
    VALID_COMMANDS   = %w(RIGHT LEFT MOVE REPORT PLACE)
    VALID_DIRECTIONS = %w(NORTH SOUTH EAST WEST)

    def initialize(options={})
      board =  options[:board] || Roboruby::Board.new
      @robot = options[:robot] || Roboruby::Robot.new({board: board})
      @command_x, @command_y, @command_f = 0, 0, "NORTH"
    end

    def start
      loop do
        solicit_new_command
        get_move(gets.chomp)
      end
    end

    def get_move(cmd)
      if is_valid_command?(cmd)
        parse_command!(cmd)
        robot.send(command, command_x, command_y, command_f)
      end
    end

    def parse_command!(cmd)
      command = cmd.split
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

    def is_valid_command?(args)
      type = args.split.first
      if VALID_COMMANDS.include?(type)
        self.command = type.downcase.to_sym; true
      else
         puts "Not a valid command #{type}. #{valid_commands}"
      end
    end

    def valid_coords?(x,y)
      begin
        Integer(x) and Integer(y)
      rescue => e
        puts e; puts valid_commands; false
      end
    end

    def valid_direction?(dir)
      return true if VALID_DIRECTIONS.include?(dir)
      puts "Not a valid direction: '#{dir}'. Valid directions #{VALID_DIRECTIONS}"
    end

    def valid_commands
      "Valid commands: #{VALID_COMMANDS}"
    end

    def solicit_new_command
      puts "\n\n\n => Type a new command:"
    end

  end
end
