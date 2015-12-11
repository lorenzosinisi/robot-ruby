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
      @direction = DIRECTIONS[2]
    end

    def default_grid
      Array.new(5) { Array.new(5) {  }  }
    end

    def get_cell(x,y)
      grid[x][y]
    end

    def set_cell(x,y, value)
      if in_grid?(x,y)
        clean_current_cell
        self.grid[x][y] = value
        self.direction = value
        self.position = [x,y]
        return true
      end
      false
    end

    def move
      case direction
        when "SOUTH"
          set_cell(current_x, current_y + 1, direction)
        when "NORTH"
          set_cell(current_x, current_y - 1, direction)
        when "EAST"
          set_cell(current_x - 1, current_y, direction)
        when "WEST"
          set_cell(current_x + 1, current_y, direction)
      end
    end

    def report
      "#{current_x}, #{current_y}, #{direction}"
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
          self.direction = "east"
        when "EAST"
          self.direction = "SOUTH"
        when "WEST"
          self.direction = "NORTH"
      end
    end

    def move_left
      case direction
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
      grid[current_x][current_y] = nil
    end

    def in_grid?(x = current_x, y = current_y)
      [0,1,2,3,4].include?(x.to_i) and [0,1,2,3,4].include?(y.to_i)
    end

  end
end
