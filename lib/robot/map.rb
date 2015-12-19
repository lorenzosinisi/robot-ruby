module Roboruby
  class Map
    class << self
      # TODO move the following instruction in a static Yaml config file as they are static anyway
      def rotate
        {
          :right => {
            :south => :west,
            :north => :east,
            :east  => :south,
            :west  => :north
          },
         :left => {
            :south => :east,
            :north => :west,
            :east  => :north,
            :west  => :south
          }
        }
      end

      def pointing
        {
          :south => {
            :x => 0,
            :y => -1,
          },
          :north => {
            :x => 0,
            :y => 1,
          },
          :east => {
            :x => 1,
            :y => 0,
          },
          :west => {
            :x => -1,
            :y => 0,
          }
        }
      end

    end
  end
end
