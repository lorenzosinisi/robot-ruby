module Robot
  class Board
    attr_reader :grid, :position, :direction
    
    def initialize
      @grid = Array.new(5) { Array.new(5) {  }  }
      @position = "0,0"
      @direction = "south"
    end

    def default_grid
      Array.new(5) { Array.new(5) {  }  }
    end

    def get_cell(x,y)
      grid[y][x]
    end

    def set_cell(x,y, value)
      grid[y][x] = value
    end

  end
end