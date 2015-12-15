module Robot
  class Board
    # this class is responsible of handling the movement of the robot on the plan
    # the grid is represented by an array of dimentions 5x5
    attr_accessor :current_x, :current_y, :direction
    # current_x current_y instead of an array
    DIRECTIONS = [
      :north,
      :east,
      :south,
      :west
    ]
    
    def initialize
      @current_x = 0
      @current_y = 0
      @direction = DIRECTIONS[0]
    end

    def place(x,y, value)
      if in_grid?(x,y)
        self.direction = value.downcase.to_sym
        self.current_x = x
        self.current_y = y
        return true
      end
      false
    end

    def move
      case direction
        when :south
          self.place(current_x, current_y - 1, direction)
        when :north
          self.place(current_x, current_y + 1, direction)
        when :east
          self.place(current_x + 1, current_y, direction)
        when :west
          self.place(current_x - 1, current_y, direction)
        else
          raise "not a valid direction #{direction}"
      end
    end

    def report
      status = [current_x, current_y, direction.to_s.upcase]
      puts status
      status
    end

    def right
      case direction
        when :south
          self.direction = :west
        when :north
          self.direction = :east
        when :east
          self.direction = :south
        when :west
          self.direction = :north
      end
    end

    def left
      case direction
        when :south
          self.direction = :east
        when :north
          self.direction = :west
        when :east
          self.direction = :north
        when :west
          self.direction = :south
      end
    end

    def in_grid?(x = current_x, y = current_y)
      (x >= 0 and x <= 4) and (y >= 0 and y <= 4)
    end

  end
end
