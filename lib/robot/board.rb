module Roboruby
  class Board
    ## Board
    # should have axis x and y by default 4 and 4 that means being big 5x5
    attr_reader :x, :y, :origin, :size

    def initialize(options={})
      @size = options[:size] || 4
      @x = options[:x] || size
      @y = options[:y] || size
      @origin = options[:origin] || 0
    end

    def in_grid?(x, y)
      (x >= origin and x <= size) and (y >= origin and y <= size)
    end

  end
end
