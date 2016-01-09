module Roboruby
  class Robot

    attr_reader :board, :compass                   # use Board and Compass in Robot memory
    attr_reader :current_x, :current_y, :direction # Store current position in robot memory

    def initialize(options={})
      @board     = options[:board] || Roboruby::Board.new
      @current_x = board.origin
      @current_y = board.origin
      @compass = options[:compass] || Compass.new
      @direction = 0
    end

    # Place should be the only method able to
    # assign new values to x,y and f of the robot
    def place(x,y, value = direction)
      if board.in_grid?(x,y)
        @current_x, @current_y, @direction = x, y, value
        report
      end
    end

    def move(*)
      dir = compass.grad_to_direction(direction)
      new_value = compass.pointing[dir]
      place(current_x + new_value[:x], current_y + new_value[:y])
    end

    def right(*)
      new_direction = compass.rotate[:right]
      place(current_x, current_y, direction + new_direction)
    end

    def left(*)
      new_direction = compass.rotate[:left]
      place(current_x, current_y, direction + new_direction)
    end

    def report(*)
      status = [current_x, current_y, @compass.grad_to_direction(direction).upcase.to_s]
      status
    end

    # The Robot itself will complain if he doesn't
    # know how to perform an action
    def method_missing(undefined_meth_yet,*args,&block)
      "#{self.class} doesn't know how to perform :#{undefined_meth_yet}"
    end

  end
end
