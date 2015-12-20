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
        it "should move a step down" do
          expect(Map.pointing[:south]).to eq ({:x=>0, :y=>-1})
        end
        it "should move a step up" do
          expect(Map.pointing[:north]).to eq ({:x=>0, :y=>1})
        end
        it "should move a step to the right" do
          expect(Map.pointing[:west]).to eq ({:x=>-1, :y=>0})
        end
        it "should move a step to the left" do
          expect(Map.pointing[:east]).to eq ({:x=>1, :y=>0})
        end
      end

      context "right/left pointing :south" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left][:south]).to eq :east
          expect(Map.rotate[:right][:south]).to eq :west
        end
      end

      context "right/left pointing :east" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left][:east]).to eq :north
          expect(Map.rotate[:right][:east]).to eq :south
        end
      end

      context "right/left pointing :north" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left][:north]).to eq :west
          expect(Map.rotate[:right][:north]).to eq :east
        end
      end

      context "right/left pointing :west" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left][:west]).to eq :south
          expect(Map.rotate[:right][:west]).to eq :north
        end
      end

      context "right/left pointing :east" do
        it "move left/right when poiting in one direction" do
          expect(Map.rotate[:left][:east]).to eq :north
          expect(Map.rotate[:right][:east]).to eq :south
        end
      end
    end

    context "#in_quadrant" do
      it "should reduce to < 360 any grad above 360" do
        expect(Map.in_quadrant(380)).to eq 20
      end
    end

    context "#to_direction" do
      it "should return the direction looking at what part of the grad are" do
        expect(Map.grad_to_direction(0)).to eq :north
        expect(Map.grad_to_direction(360)).to eq :north
        expect(Map.grad_to_direction(rand(1..98))).to eq :northeast
        expect(Map.grad_to_direction(90)).to eq :east
        expect(Map.grad_to_direction(rand(91..179))).to eq :southeast
        expect(Map.grad_to_direction(180)).to eq :south

      end
    end
  end
end
