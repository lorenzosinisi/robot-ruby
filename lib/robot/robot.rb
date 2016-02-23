module Roboruby
  class Robot

    attr_reader :board, :compass, :current_x, :current_y, :direction

    def initialize(options={})
      @board   = options[:board]   || Roboruby::Board.new
      @compass = options[:compass] || Compass.new
      @current_x, @current_y, @direction = 0, 0, 0 # direction 0 means north
    end

    # Place should be the only method able to
    # assign new values to x,y and f of the robot
    def place(x,y, value = direction)
      if can_i_move?(x,y)
        @current_x = x
        @current_y = y
        @direction = value 
        report 
      else
        "Attempt to move into an invalid position"
      end
    end

    # move a step into the current direction
    def move(*)
      dir = compass.grad_to_direction(direction)
      new_value = compass.pointing[dir]
      place(current_x + new_value[:x], current_y + new_value[:y])
    end

    # rotate right
    def right(*)
      new_direction = compass.rotate :right
      place(current_x, current_y, direction + new_direction)
    end

    # rotate left
    def left(*)
      new_direction = compass.rotate :left
      place(current_x, current_y, direction + new_direction)
    end

    # print x,y, direction
    def report(*)
      [current_x, current_y, compass.grad_to_direction(direction).to_s.upcase]
    end

    # exit from the console session
    def quit(*)
      exit!
    end

    # return true if the attemped new x,y is in the array of valid coordinates
    def can_i_move?(x,y)
      (x.to_i >= 0 and x.to_i <= board.width) and (y.to_i >= 0 and y.to_i <= board.height)
    end

    # The Robot itself will complain if he doesn't
    # know how to perform an action
    def method_missing(undefined_meth_yet,*args,&block)
      "#{self.class.to_s} doesn't know how to perform :#{undefined_meth_yet}"
    end

  end
end
