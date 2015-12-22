module Roboruby
  class Map
    class << self
      # add or remove 90 deg depending on the rotation
      def rotate
        {
          :right => +90,
          :left => -90,
        }
      end

      # depending on the position that the robot is facing, add or remove a value from x and y
      # 0  > means nothing to do
      # 1  > means add 1
      # -1 > means remove 1
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
        if val == 0
          :north
        elsif val.between?(1, 89)
          :northeast
        elsif val == 90
          :east
        elsif val.between?(91, 179)
          :southeast
        elsif val == 180
          :south
        elsif val.between?(181, 269)
          :southwest
        elsif val == 270
          :west
        elsif val.between?(271, 359)
          :northwest
        elsif val == 360
          :north
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
