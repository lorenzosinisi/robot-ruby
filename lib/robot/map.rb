module Roboruby
  class Map
    class << self
      # TODO move the following instruction in a static Yaml config file as they are static anyway
      def rotate
        {
          :right => +90,
          :left => -90,
        }
      end

      def pointing
        {
          :south => {
            :x => 0,
            :y => -1,
          },
          :southeast => {
            :x => 1,
            :y => -1,
          },
          :north => {
            :x => 0,
            :y => 1,
          },
          :northeast => {
            :x => 1,
            :y => 1,
          },
          :east => {
            :x => 1,
            :y => 0,
          },
          :west => {
            :x => -1,
            :y => 0,
          },
          :southwest => {
            :x => -1,
            :y => -1,
          },
          :northwest => {
            :x => -1,
            :y => 1,
          }
        }
      end

      # Simply translate the coors into a human direction
      def grad_to_direction(grads)
        val = in_quadrant(grads)
        if val == 0 or val == 360
          :north
        elsif val.between?(1, 89)
          :northeast
        elsif val == 90
          :east
        elsif val.between?(89, 179)
          :southeast
        elsif val == 180
          :south
        elsif val.between?(179, 269)
          :southwest
        elsif val == 270
          :west
        elsif val.between?(269, 359)
          :northwest
        else
          raise "Something here is going wrong, please have a look at the value: #{val}"
        end
      end

      # try to reduce the grads to a number between 0 and 360
      # this may break when a robot does a really really big number of cycles around the axis
      # be careful
      def in_quadrant(grads)
        if grads > 360
          grads -= 360
          return in_quadrant(grads)
        elsif
          grads < 0
          grads += 360
          return in_quadrant(grads)
        end
        grads
      end

    end
  end
end
