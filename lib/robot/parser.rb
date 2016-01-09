module Roboruby
  class Parser

    def initialize
      @compass = Compass.new
    end

    def parse(cmd)
      @to_execute = []
      cmd = cmd.split
      command = cmd[0].to_s.downcase.to_sym
      args = cmd[1]
      @to_execute.push(command)
      extract_arguments!(args) if args

      @to_execute
    end

    def extract_arguments!(args)
      args = args.split(",")
      x, y, f = args[0], args[1], args[2]
      direction = @compass.direction_to_grads(f)
      @to_execute.push(x.to_i)
      @to_execute.push(y.to_i)
      @to_execute.push(direction.to_i)
    end

  end
end