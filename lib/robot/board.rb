module Roboruby
  class Board
    ## Board
    # should have axis x and y by default 4 and 4 that means being big 5x5
    attr_reader :x, :y, :origin

    def initialize(options={})
      @x = options[:x] || 4
      @y = options[:y] || 4
      @origin = options[:origin] || 0
    end

  end
end
