module Robot
  class Board
    # this class is responsible of handling the movement of the robot on the plan
    # the grid is represented by an array of dimentions 5x5
    attr_accessor :current_x, :current_y, :direction
    # current_x current_y instead of an array
    DIRECTIONS = [
      "NORTH",
      "EAST",
      "SOUTH",
      "WEST"
    ]

    def initialize
      @current_x = 0
      @current_y = 0
      # default direction NORTH
      @direction = DIRECTIONS[0]
    end

    def set_cell(x,y, value)
      if in_grid?(x,y)
        self.direction = value
        self.current_x = x
        self.current_y = y
        return true
      end
      false
    end

    def move
      case self.direction.downcase.to_sym
        when :south
          self.set_cell(current_x, current_y - 1, direction)
        when :north
          self.set_cell(current_x, current_y + 1, direction)
        when :east
          self.set_cell(current_x + 1, current_y, direction)
        when :west
          self.set_cell(current_x - 1, current_y, direction)
      end
    end

    def report
      [current_x, current_y, direction]
    end

    def move_right
      case self.direction.downcase.to_sym
        when :south
          self.direction = "WEST"
        when :north
          self.direction = "EAST"
        when :east
          self.direction = "SOUTH"
        when :west
          self.direction = "NORTH"
      end
    end

    def move_left
      case self.direction.downcase.to_sym
        when :south
          self.direction = "EAST"
        when :north
          self.direction = "WEST"
        when :east
          self.direction = "NORTH"
        when :west
          self.direction = "SOUTH"
      end
    end

    def in_grid?(x = current_x, y = current_y)
      (x >= 0 and x <= 4) and (y >= 0 and y <= 4)
    end

  end
end
