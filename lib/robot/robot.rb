module Roboruby
  class Robot

    attr_accessor :current_x, :current_y, :direction
    attr_reader :board
    DIRECTIONS = [:north, :east, :south, :west]

    def initialize(options={})
      @board = options[:board] || Roboruby::Board.new
      @current_x = board.origin
      @current_y = board.origin
      @direction = :north
    end

    def place(x,y, value)
      if in_grid?(x,y)
        self.direction = value.downcase.to_sym
        self.current_x = x
        self.current_y = y
        true
      end
    end

    def move(*)
      new_value = movements[direction].first
      self.place(new_value[:x], new_value[:y], new_value[:direction])
    end

    def right(*)
      self.direction = movements[:right].first[direction]
    end

    def left(*)
      self.direction = movements[:left].first[direction]
    end

    def shake(*)
      new_value = movements[:shake].first
      self.place(new_value[:x], new_value[:y], new_value[:direction])
    end

    def movements
      [ #:shake => [ # Pointing direction
        #  :x => rand(board.origin..board.size), # new x
        #  :y => rand(board.origin..board.size), # New y
        #  :direction => direction # direction
        #],
        # Move when direction is:
        :south => [ # Pointing direction
          :x => current_x, # new x
          :y => current_y - 1, # New y
          :direction => direction # direction
        ],
        :north => [
          :x => current_x,
          :y => current_y + 1,
          :direction => direction
        ],
        :east => [
          :x => current_x + 1,
          :y => current_y,
          :direction => direction
        ],
        :west => [
          :x => current_x - 1,
          :y => current_y,
          :direction => direction
        ],
        # Rotate in direction:
        :left => [
          :south => :east,
          :north => :west,
          :east => :north,
          :west => :south
        ],
        :right => [
          :south => :west,
          :north => :east,
          :east => :south,
          :west => :north
        ]
       ][0]
    end

    def report(*)
      status = [current_x, current_y, direction.to_s.upcase]
      puts status
      status
    end

    def in_grid?(x = current_x, y = current_y)
      (x >= board.origin and x <= board.x) and (y >= board.origin and y <= board.x)
    end

  end
end
