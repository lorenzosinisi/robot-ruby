module Roboruby
  class Compass

    # Ddd or remove 90 deg depending on the rotation
    def rotate
      {
        :right => +90,
        :left => -90,
      }.freeze
    end

    # Depending on the position that the robot is facing, add or remove a value from x and y
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
      }.freeze
    end

    # Translate the coors into a human direction
    def grad_to_direction(grads)
      angle = to_quadrant(grads)
      if angle == 0
        :north
      elsif angle.between?(1, 89)
        :northeast
      elsif angle == 90
        :east
      elsif angle.between?(91, 179)
        :southeast
      elsif angle == 180
        :south
      elsif angle.between?(181, 269)
        :southwest
      elsif angle == 270
        :west
      elsif angle.between?(271, 359)
        :northwest
      elsif angle == 360
        :north
      else
        raise "Something here is going wrong, please have a look at the value: #{angle}"
      end
    end

    # Translate the direction into grads
    def direction_to_grads(direction)
      case direction.to_s.downcase.to_sym
      when :north
        0
      when :northeast
        45
      when :east
        90
      when :southeast
        135
      when :south
        180
      when :southwest
        225
      when :west
        270
      when :northwest
        315
      else
        raise "Don't know how to move in direction #{direction.to_s}"
      end
    end

    # Translate an Integer into an angle in a 360° quadrant
    def to_quadrant(grads)
      grads.to_i % 360 # conver rotation in grads to an angle IN the compass
    end

  end
end
