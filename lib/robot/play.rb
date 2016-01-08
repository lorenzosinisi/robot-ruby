module Roboruby
  class Play
    # why duplicated action
    # type some commen
    attr_accessor :command, :command_x, :command_y, :command_f
    attr_reader :robot, :name

    VALID_DIRECTIONS = %w(NORTH SOUTH WEST EAST NORTHEAST NORTHWEST SOUTHWEST SOUTHEAST).freeze

    def initialize(options={})
      @board =  options[:board] || Roboruby::Board.new
      @compass =  options[:compass] || Compass.new
      @robot = options[:robot] || Roboruby::Robot.new({board: @board, compass: @compass})
      @command_x, @command_y, @command_f = 0, 0, 0
      @name = options[:name] || self.object_id
    end

    def get_move(cmd)
      parse_command!(cmd)
      robot.send(command, command_x, command_y, command_f)
    end

    def parse_command!(cmd)
      command = cmd.split
      args = command[1]
      @command = command[0].downcase.to_sym
      extract_arguments!(args) if args
    end

    def extract_arguments!(args)
      args = args.split(",")
      x, y, f = args[0], args[1], args[2]
      direction = @compass.direction_to_grads(f)
      if valid_coords?(x,y) and valid_direction?(f)
        @command_x = Integer(x)
        @command_y = Integer(y)
        @command_f = direction
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

  end
end
