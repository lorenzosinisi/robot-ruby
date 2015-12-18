module Roboruby
  class Board

    attr_accessor :x, :y

    def initialize(options={})
      @x = options[:x] || 4
      @y = options[:y] || 4
    end

  end
end
