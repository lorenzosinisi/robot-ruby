module Robot
  class Board
    # this class is responsible of handling the movement of the robot on the plan
    # the grid is represented by an array of dimentions 5x5
    attr_accessor :grid, :position, :direction
    DIRECTIONS = [
      "nord",
      "east",
      "south",
      "west"
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
        grid[x][y] = value
        self.position = [x,y]
        return true
      end
      false
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
      current_direction = DIRECTIONS.index(@direction)
      new_direction_idx = current_direction + 1
      self.direction = DIRECTIONS[new_direction_idx]
    end

    def move_left
      current_direction = DIRECTIONS.index(@direction)
      new_direction_idx = current_direction - 1
      self.direction = DIRECTIONS[new_direction_idx]
    end

    def clean_current_cell
      grid[current_x][current_y] = nil
    end

    def in_grid?(x = current_x, y = current_y)
      [0,1,2,3,4].include?(x) and [0,1,2,3,4].include?(y)
    end

  end
end
