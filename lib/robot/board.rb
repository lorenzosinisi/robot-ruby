module Robot
  class Board
    # this class is responsible of handling the movement of the robot on the plan
    # the grid is represented by an array of dimentions 5x5
    attr_accessor :grid, :position, :direction
    DIRECTIONS = [
      "NORTH",
      "EAST",
      "SOUTH",
      "WEST"
    ]
    def initialize
      # create the grid 5x5
      @grid = default_grid
      @position = [0,0]
      # position the direction to south
      @direction = DIRECTIONS[0]
    end

    def default_grid
      Array.new(5) { Array.new(5) {} }
    end

    def get_cell(x,y)
      self.grid[x][y]
    end

    def set_cell(x,y, value)
      if in_grid?(x,y)
        self.clean_current_cell
        self.grid[x][y] = value
        self.direction = value
        self.position = [x,y]
        return true
      end
      false
    end

    def move
      # TABLE:
      #  y
      #  - - - - -
      #  - - - - -
      #  - - - - -
      #  - - - - -
      #  0,0 - - - X
      # # # # # # # #
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

    def clean_current_cell
      grid[self.current_x][self.current_y] = nil
    end

    def in_grid?(x = current_x, y = current_y)
      [0,1,2,3,4].include?(x) and [0,1,2,3,4].include?(y)
    end

  end
end
