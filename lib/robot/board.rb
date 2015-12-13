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
      @current_x, @current_y = 0,0
      # default direction NORTH
      @direction = DIRECTIONS[0]
    end

    def default_grid
      Array.new(5) { Array.new(5) {} }
    end
    # use constrain > 0 < 4
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
      case direction
        when "SOUTH"
          self.set_cell(current_x, current_y - 1, direction)
        when "NORTH"
          self.set_cell(current_x, current_y + 1, direction)
        when "EAST"
          self.set_cell(current_x + 1, current_y, direction)
        when "WEST"
          self.set_cell(current_x - 1, current_y, direction)
      end
    end

    def report
      "#{self.current_x}, #{self.current_y}, #{self.direction}"
    end

    def move_right
      case self.direction
        when "SOUTH"
          self.direction = "WEST"
        when "NORTH"
          self.direction = "EAST"
        when "EAST"
          self.direction = "SOUTH"
        when "WEST"
          self.direction = "NORTH"
      end
    end

    def move_left
      case self.direction
        when "SOUTH"
          self.direction = "EAST"
        when "NORTH"
          self.direction = "WEST"
        when "EAST"
          self.direction = "NORTH"
        when "WEST"
          self.direction = "SOUTH"
      end
    end

    def in_grid?(x = current_x, y = current_y)
      (x >= 0 and x <= 4) and (y >= 0 and y <= 4)
    end

  end
end
