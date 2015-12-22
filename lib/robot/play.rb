module Roboruby
  class Play
    attr_accessor :robot, :command, :command_x, :command_y, :command_f
    VALID_COMMANDS   = %w(RIGHT LEFT MOVE REPORT PLACE)

    def initialize(options={})
      board =  options[:board] || Roboruby::Board.new
      @robot = options[:robot] || Roboruby::Robot.new({board: board})
      @command_x, @command_y, @command_f = 0, 0, 0
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
      if valid_coords?(x,y, f)
        self.command_x = Integer(x)
        self.command_y = Integer(y)
        self.command_f = Integer(f)
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

    def valid_coords?(x,y,f)
      begin
        Integer(x)
        Integer(y)
        valid_direction?(f)
      rescue => e
        puts e; puts valid_commands; false
      end
    end

    def valid_direction?(dir)
      dir = Integer(dir)
      dir >= 0 and dir <= 360
    end

    def valid_commands
      "Valid commands: #{VALID_COMMANDS}"
    end

    def solicit_new_command
      puts "\n\n\n => Type a new command:"
    end

  end
end
