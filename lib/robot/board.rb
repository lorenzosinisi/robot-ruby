module Roboruby
  class Board
    ## Board
    # should have axis x and y by default 4 and 4 that means being big 5x5
    attr_reader :x, :y, :origin, :movements, :size

    def initialize(options={})
      @size = options[:size] || 4
      @x = options[:x] || size
      @y = options[:y] || size
      @origin = options[:origin] || 0
    end

  end
end
