module Roboruby
  class Robot

    attr_accessor :current_x, :current_y, :direction
    attr_reader :board

    def initialize(options={})
      @board     = options[:board] || Roboruby::Board.new
      @current_x = board.origin
      @current_y = board.origin
      @direction = 0
    end

    def place(x,y, value = direction)
      if board.in_grid?(x,y)
        self.direction = value
        self.current_x = x
        self.current_y = y
        true
      end
    end

    def move(*)
      dir = Compass.grad_to_direction(direction)
      new_value = Compass.pointing[dir]
      place(current_x + new_value[:x], current_y + new_value[:y])
    end

    def right(*)
      new_direction = Compass.rotate[:right]
      place(current_x, current_y, direction + new_direction)
    end

    def left(*)
      new_direction = Compass.rotate[:left]
      place(current_x, current_y, direction + new_direction)
    end

    def report(*)
      status = [current_x, current_y, human_direction]
      puts status
      status
    end

    def human_direction
      Compass.grad_to_direction(direction).upcase.to_s
    end

  end
end
