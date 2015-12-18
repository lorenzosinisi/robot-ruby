module Roboruby
  class Board

    attr_accessor :x, :y, :origin

    def initialize(options={})
      @x = options[:x] || 4
      @y = options[:y] || 4
      @origin = options[:origin] || 0
    end

  end
end
