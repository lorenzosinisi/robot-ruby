require 'spec_helper'

module Roboruby
  describe Map do
    subject { Map }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Map).to be Roboruby::Map
      end
    end

    context "#movements should return the new position of the robot" do
      context "#move pointing different directions" do
        it "down" do
          expect(Map.pointing[:south]).to eq ({:x=>0, :y=>-1})
        end
        it "up" do
          expect(Map.pointing[:north]).to eq ({:x=>0, :y=>1})
        end
        it "right" do
          expect(Map.pointing[:west]).to eq ({:x=>-1, :y=>0})
        end
        it "left" do
          expect(Map.pointing[:east]).to eq ({:x=>1, :y=>0})
        end
        context "diagonal movement" do
          it "southwest" do
            expect(Map.pointing[:southwest]).to eq ({:x=>-1, :y=>-1})
          end
          it "southeast" do
            expect(Map.pointing[:southeast]).to eq ({:x=>1, :y=>-1})
          end
          it "northeast" do
            expect(Map.pointing[:northeast]).to eq ({:x=>1, :y=>1})
          end
          it "northwest" do
            expect(Map.pointing[:northwest]).to eq ({:x=>-1, :y=>1})
          end
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{Map.pointing[:ciao] = "ciao"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end

      context "right/left" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left]).to eq(-90)
          expect(Map.rotate[:right]).to eq(90)
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{Map.rotate[:polos_lollipop] = "polos_lollipop"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end
    end

    context "#in_quadrant" do
      it "should reduce to < 360 any grad above 360" do
        expect(Map.to_quadrant(380)).to eq 20
      end
      it "should return nil when the operation can't be done" do
        expect(Map.to_quadrant("can't convert a string into deg")).to eq nil
      end
      it "should support also Bignum" do
        expect(Map.to_quadrant(1000000000000000000000000 * 1000000000000000000000000)).to eq 280
      end
    end

    context "#to_direction" do
      it "should return the direction looking at what part of the grad are" do
        expect(Map.grad_to_direction(0)).to eq :north
        expect(Map.grad_to_direction(360)).to eq :north
        expect(Map.grad_to_direction(rand(1..89))).to eq :northeast
        expect(Map.grad_to_direction(90)).to eq :east
        expect(Map.grad_to_direction(rand(91..179))).to eq :southeast
        expect(Map.grad_to_direction(180)).to eq :south

      end
    end
  end
end
