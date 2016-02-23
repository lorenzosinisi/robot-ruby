module Roboruby
  class Board
    attr_reader :width, :height, :size

    def initialize(options={})
      default_size = 4
      @size   = are_axis_valid? options[:size]   || default_size
      @width  = are_axis_valid? options[:width]  || default_size
      @height = are_axis_valid? options[:height] || default_size
    end

    private

    def are_axis_valid?(size)
      return nil unless size # so we can use the default value
      size.abs # we want always a positive number for valid axis
    end

  end
end
