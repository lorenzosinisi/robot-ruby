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
      place(new_value[:x], new_value[:y])
    end

    # Command right
    def right(*)
      new_direction = movements[:right].first[direction]
      place(current_x, current_y, new_direction)
    end

    # Command left
    def left(*)
      new_direction = movements[:left].first[direction]
      place(current_x, current_y, new_direction)
    end

    # Command shake
    def shake(*)
      new_position = movements[:shake].first
      x,y,f = new_position[:x], new_position[:y], new_position[:direction]
      place(x, y, f)
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
        # Position the robot randomply in the board
        :shake => [
          :x => rand(board.origin..board.size),
          :y => rand(board.origin..board.size),
          :direction => DIRECTIONS.sample
        ],

        ## MAPPING FOR COMMAND MOVE
        # Move one step in the current direction by accessing the actual direction:
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
        # TODO to enable also diagonal movements
        #:southeast => [
        #  :x => current_x + 1 ,
        #  :y => current_y - 1,
        #  :direction => direction
        #]

        ## MAPPING FOR COMMAND LEFT
        # Rotate in direction:
        :left => [
          :south => :east,
          :north => :west,
          :east  => :north,
          :west  => :south
        ],
        # TODO to enable also diagonal movements
        #:left => [
        #  :south     => :southwest,
        #  :southwest => :west,
        #  etc...
        #]

        ## MAPPING FOR COMMAND RIGHT
        # Rotate in direction:
        :right => [
          :south => :west,
          :north => :east,
          :east  => :south,
          :west  => :north
        ]

       ].first
    end

  end
end
