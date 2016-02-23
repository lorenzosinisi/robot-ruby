module Roboruby
  class Parser

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
      x, y, f = args[0].to_i, args[1].to_i, args[2]
      direction = Compass.new.direction_to_grads(f)
      
      @to_execute.push(x, y, direction)
    end

  end
end