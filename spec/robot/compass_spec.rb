require 'spec_helper'

module Roboruby
  describe Compass do
    subject { Compass.new }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Compass).to be Roboruby::Compass
      end
    end

    context "#movements should return the new position of the robot" do
      context "#move pointing different directions" do
        it "down" do
          expect(subject.pointing[:south]).to eq ({:x=>0, :y=>-1})
        end
        it "up" do
          expect(subject.pointing[:north]).to eq ({:x=>0, :y=>1})
        end
        it "right" do
          expect(subject.pointing[:west]).to eq ({:x=>-1, :y=>0})
        end
        it "left" do
          expect(subject.pointing[:east]).to eq ({:x=>1, :y=>0})
        end
        context "diagonal movement" do
          it "southwest" do
            expect(subject.pointing[:southwest]).to eq ({:x=>-1, :y=>-1})
          end
          it "southeast" do
            expect(subject.pointing[:southeast]).to eq ({:x=>1, :y=>-1})
          end
          it "northeast" do
            expect(subject.pointing[:northeast]).to eq ({:x=>1, :y=>1})
          end
          it "northwest" do
            expect(subject.pointing[:northwest]).to eq ({:x=>-1, :y=>1})
          end
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{subject.pointing[:ciao] = "ciao"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end

      context "right/left" do
        it "move left/right when poiting in one direction" do
          expect(subject.rotate[:left]).to eq(-90)
          expect(subject.rotate[:right]).to eq(90)
        end
        context "if trying to modify the hash" do
          it "should raise error" do
            expect{subject.rotate[:polos_lollipop] = "polos_lollipop"}.to raise_error(RuntimeError, "can't modify frozen Hash")
          end
        end
      end
    end

    context "#in_quadrant" do
      it "should reduce to < 360 any grad above 360" do
        expect(subject.to_quadrant(380)).to eq 20
      end
      it "should return the error when the operation can't be done" do
        expect(subject.to_quadrant("can't convert a string into deg")).to eq 0
      end
      it "should support also Bignum" do 
        expect(subject.to_quadrant(1000000000000000000000000 * 1000000000000000000000000)).to eq 280
      end
    end

    context "#to_direction" do
      it "should return the direction looking at what part of the grad are" do
        expect(subject.grad_to_direction(0)).to eq :north
        expect(subject.grad_to_direction(360)).to eq :north
        expect(subject.grad_to_direction(rand(1..89))).to eq :northeast
        expect(subject.grad_to_direction(90)).to eq :east
        expect(subject.grad_to_direction(rand(91..179))).to eq :southeast
        expect(subject.grad_to_direction(180)).to eq :south
      end
    end
  end
end
