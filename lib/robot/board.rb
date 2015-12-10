module Robot
  class Board
    attr_accessor :grid, :position, :direction
    DIRECTIONS = [
      "nord",
      "east",
      "south",
      "west"
    ]
    
    def initialize
      @grid = Array.new(5) { Array.new(5) {  }  }
      @position = [0,0]
      @direction = DIRECTIONS[2]
    end

    def default_grid
      Array.new(5) { Array.new(5) {  }  }
    end

    def get_cell(x,y)
      grid[x][y]
    end

    def set_cell(x,y, value)
      clean_current_cell
      grid[x][y] = value
      self.position = [x,y]
      value
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

  end
end