module Roboruby
  class Parser
    # bad design, you can't really re-use the code below. Needs improvements
    
    def parse(cmd)
      @to_execute = []
      cmd = cmd.split
      extract_command!(cmd[0])
      extract_arguments!(cmd[1])
      @to_execute.to_a
    end

    def extract_command!(cmd)
      command = cmd.to_s.downcase.to_sym
      @to_execute.push(command)
    end

    def extract_arguments!(args)
      return if args.nil?     # return in case there are no arguments
      args = args.split(",")  # the arguments must be passed as a list separated by comma
      # where f is the direction in string
      x, y, f = args[0].to_i, args[1].to_i, args[2]
      # using the helper function to convert the string into an angle (i.e. north => 0)
      direction = Compass.new.direction_to_grads(f)
      @to_execute.push(x, y, direction)
    end

  end
end