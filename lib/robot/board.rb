module Robot
  class Board
    # this class is responsible of handling the movement of the robot on the plan
    # the grid is represented by an array of dimentions 5x5
    attr_accessor :position, :direction
    DIRECTIONS = [
      "NORTH",
      "EAST",
      "SOUTH",
      "WEST"
    ]
    def initialize
      @position = [0,0]
      # default direction NORTH
      @direction = DIRECTIONS[0]
    end

    def default_grid
      Array.new(5) { Array.new(5) {} }
    end

    def set_cell(x,y, value)
      if in_grid?(x,y)
        self.direction = value
        self.position = [x,y]
        return true
      end
      false
    end

    def move
      case direction
        when "SOUTH"
          self.set_cell(position[0], position[1] - 1, direction)
        when "NORTH"
          self.set_cell(position[0], position[1] + 1, direction)
        when "EAST"
          self.set_cell(position[0] + 1, position[1], direction)
        when "WEST"
          self.set_cell(position[0] - 1, position[1], direction)
      end
    end

    def report
      "#{self.position[0]}, #{self.position[1]}, #{self.direction}"
    end

    def current_x
      self.position[0]
    end

    def current_y
      self.position[0]
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
      [0,1,2,3,4].include?(x) and [0,1,2,3,4].include?(y)
    end

  end
end
