module Roboruby
  class Robot

    attr_accessor :current_x, :current_y, :direction
    attr_reader :board
    DIRECTIONS = [:north, :east, :south, :west]

    def initialize(options={})
      @board     = options[:board] || Roboruby::Board.new
      @current_x = board.origin
      @current_y = board.origin
      @direction = :north
    end

    # Command place
    def place(x,y, value = direction)
      if board.in_grid?(x,y)
        self.direction = value.downcase.to_sym
        self.current_x = x
        self.current_y = y
        true
      end
    end

    # Command move
    def move(*)
      new_value = step[direction]
      place(new_value[:x], new_value[:y])
    end

    # Command right
    def right(*)
      new_direction = rotation[:right][direction]
      place(current_x, current_y, new_direction)
    end

    # Command left
    def left(*)
      new_direction = rotation[:left][direction]
      place(current_x, current_y, new_direction)
    end

    # Command shake
    def shake(*)
      x,y,f = random[:x], random[:y], random[:direction]
      place(x, y, f)
    end

    # Command report
    def report(*)
      status = [current_x, current_y, direction.to_s.upcase]
      puts status
      status
    end

    def rotation
      {
        :right => {
          :south => :west,
          :north => :east,
          :east  => :south,
          :west  => :north
        },
       :left => {
          :south => :east,
          :north => :west,
          :east  => :north,
          :west  => :south
        }
      }
    end

    def step
      {
        :south => {
          :x => current_x,
          :y => current_y - 1,
        },
        :north => {
          :x => current_x,
          :y => current_y + 1,
        },
        :east => {
          :x => current_x + 1,
          :y => current_y,
        },
        :west => {
          :x => current_x - 1,
          :y => current_y,
        }
      }
    end

    def random
      { 
        :x => rand(board.origin..board.size),
        :y => rand(board.origin..board.size),
        :direction => DIRECTIONS.sample
      }
    end

  end
end