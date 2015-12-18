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

    # Command place
    def place(x,y, value = direction)
      if in_grid?(x,y)
        self.direction = value.downcase.to_sym
        self.current_x = x
        self.current_y = y
        true
      end
    end

    # Command move
    def move(*)
      new_value = movements[direction].first
      self.place(new_value[:x], new_value[:y])
    end

    # Command right
    def right(*)
      self.direction = movements[:right].first[direction]
    end

    # Command left
    def left(*)
      self.direction = movements[:left].first[direction]
    end

    # Command shake
    def shake(*)
      new_value = movements[:shake].first
      self.place(new_value[:x], new_value[:y], new_value[:direction])
    end

    # Command report
    def report(*)
      status = [current_x, current_y, direction.to_s.upcase]
      puts status
      status
    end

    def in_grid?(x = current_x, y = current_y)
      (x >= board.origin and x <= board.x) and (y >= board.origin and y <= board.x)
    end

    def movements
      [
        # MAPPING FOR COMMAND SHAKE
        :shake => [
          :x => rand(board.origin..board.size),
          :y => rand(board.origin..board.size),
          :direction => DIRECTIONS.sample
        ],

        ## MAPPING FOR COMMAND MOVE
        # Move one step when direction is:
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

        ## MAPPING FOR COMMAND LEFT
        # Rotate in direction:
        :left => [
          :south => :east,
          :north => :west,
          :east  => :north,
          :west  => :south
        ],

        ## MAPPING FOR COMMAND RIGHT
        # Rotate in direction:
        :right => [
          :south => :west,
          :north => :east,
          :east  => :south,
          :west  => :north
        ]

       ][0]
    end

  end
end
