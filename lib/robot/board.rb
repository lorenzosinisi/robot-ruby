module Roboruby
  class Board
    ## Board
    # should have axis x and y by default 4 and 4 that means being big 5x5
    attr_reader :width, :height, :size

    def initialize(options={})
      @size   = options[:size] || 4
      @width  = valid_axis(options[:width]) || size
      @height = valid_axis(options[:height]) || size
    end

    # check that the borad doesn't have negative numbers as size
    def valid_axis(size)
      return nil if size == nil
      size = size >= 0 ? size : 0
    end

  end
end
