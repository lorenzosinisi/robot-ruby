module Roboruby
  class Board
    ## Board
    # should have axis x and y by default 4 and 4 that means being big 5x5
    attr_reader :x, :y, :origin, :size
    attr_accessor :valid_points

    def initialize(options={})
      @size = options[:size] || 4
      @x = options[:x] || size
      @y = options[:y] || size
      @origin = options[:origin] || 0
      @valid_points = valid_coords
    end

    # Call this method to check if the coords are valid or not
    # resource indicate the presence of an object in the cell, false means free
    def in_grid?(x, y, resource = false)
      begin
        valid_points[x][y] == [x,y, resource]
      rescue
      end
    end

    # Generate a square of 5x5, each point contains an array like [x,y and false] by default to mark the cell
    # as valid and free (false)
    def valid_coords
      Array.new(size + 1) { |x|
        Array.new(size + 1) { |y|
          [x,y, false]
        }.freeze
      }.freeze
    end

  end
end
