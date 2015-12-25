module Roboruby
  class Play
    attr_accessor :command, :command_x, :command_y, :command_f
    attr_reader :robot, :name
    VALID_COMMANDS   = %w(RIGHT LEFT MOVE REPORT PLACE)
    VALID_DIRECTIONS = %w(NORTH SOUTH WEST EAST NORTHEAST NORTHWEST SOUTHWEST SOUTHEAST)

    def initialize(options={})
      board =  options[:board] || Roboruby::Board.new
      @robot = options[:robot] || Roboruby::Robot.new({board: board})
      @command_x, @command_y, @command_f = 0, 0, 0
      @name = options[:name] || self.object_id
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
      args = command[1]
      extract_arguments!(args) if args
    end

    def extract_arguments!(args)
      args = args.split(",")
      x, y, f = args[0], args[1], args[2]
      direction = Map.direction_to_grads(f)
      if valid_coords?(x,y) and valid_direction?(f)
        self.command_x = Integer(x)
        self.command_y = Integer(y)
        self.command_f = direction
      end
    end

    def is_valid_command?(args)
      type = args.split.first
      if VALID_COMMANDS.include?(type)
        self.command = type.downcase.to_sym; true
      else
         puts "Not a valid command #{type}. Valid commands #{VALID_COMMANDS}"
      end
    end

    def valid_coords?(x,y)
      begin
        Integer(x)
        Integer(y)
      rescue => e
        puts e; puts valid_commands; false
      end
    end

    def valid_direction?(direction)
      return true if VALID_DIRECTIONS.include?(direction)
      puts "Sorry, are valid directions only: #{VALID_DIRECTIONS}"
    end

    def solicit_new_command
      puts "\n\n\n => Type a new command:"
    end

    def its_your_time
     puts "It's your time #{name}! Select your move:"
    end

  end
end
