require 'spec_helper'

module Roboruby
  describe Compass do
    subject { Compass }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Compass).to be Roboruby::Compass
      end
    end

    context "#movements should return the new position of the robot" do
      context "#move pointing different directions" do
        it "down" do
          expect(Compass.pointing[:south]).to eq ({:x=>0, :y=>-1})
        end
        it "up" do
          expect(Compass.pointing[:north]).to eq ({:x=>0, :y=>1})
        end
        it "right" do
          expect(Compass.pointing[:west]).to eq ({:x=>-1, :y=>0})
        end
        it "left" do
          expect(Compass.pointing[:east]).to eq ({:x=>1, :y=>0})
        end
        context "diagonal movement" do
          it "southwest" do
            expect(Compass.pointing[:southwest]).to eq ({:x=>-1, :y=>-1})
          end
          it "southeast" do
            expect(Compass.pointing[:southeast]).to eq ({:x=>1, :y=>-1})
          end
          it "northeast" do
            expect(Compass.pointing[:northeast]).to eq ({:x=>1, :y=>1})
          end
          it "northwest" do
            expect(Compass.pointing[:northwest]).to eq ({:x=>-1, :y=>1})
          end
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{Compass.pointing[:ciao] = "ciao"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end

      context "right/left" do
        it "move left/right when poiting in one direction" do
          expect(Compass.rotate[:left]).to eq(-90)
          expect(Compass.rotate[:right]).to eq(90)
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{Compass.rotate[:polos_lollipop] = "polos_lollipop"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end
    end

    context "#in_quadrant" do
      it "should reduce to < 360 any grad above 360" do
        expect(Compass.to_quadrant(380)).to eq 20
      end
      it "should return nil when the operation can't be done" do
        expect(Compass.to_quadrant("can't convert a string into deg")).to eq nil
      end
      it "should support also Bignum" do 
        expect(Compass.to_quadrant(1000000000000000000000000 * 1000000000000000000000000)).to eq 280
      end
    end

    context "#to_direction" do
      it "should return the direction looking at what part of the grad are" do
        expect(Compass.grad_to_direction(0)).to eq :north
        expect(Compass.grad_to_direction(360)).to eq :north
        expect(Compass.grad_to_direction(rand(1..89))).to eq :northeast
        expect(Compass.grad_to_direction(90)).to eq :east
        expect(Compass.grad_to_direction(rand(91..179))).to eq :southeast
        expect(Compass.grad_to_direction(180)).to eq :south

      end
    end
  end
end
