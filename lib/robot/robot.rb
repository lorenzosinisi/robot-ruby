module Roboruby
  class Robot

    attr_accessor :current_x, :current_y, :direction
    attr_reader :board

    def initialize(options={})
      @board     = options[:board] || Roboruby::Board.new
      @current_x = board.origin
      @current_y = board.origin
      @direction = :north
    end

    def place(x,y, value = direction)
      if board.in_grid?(x,y)
        self.direction = value.downcase.to_sym
        self.current_x = x
        self.current_y = y
        true
      end
    end

    def move(*)
      new_value = Map.pointing[direction]
      place(current_x + new_value[:x], current_y + new_value[:y])
    end

    def right(*)
      new_direction = Map.rotate[:right][direction]
      place(current_x, current_y, new_direction)
    end

    def left(*)
      new_direction = Map.rotate[:left][direction]
      place(current_x, current_y, new_direction)
    end

    def report(*)
      status = [current_x, current_y, direction.to_s.upcase]
      puts status
      status
    end

  end
end