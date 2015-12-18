require 'spec_helper'

module Roboruby
  describe Robot do

    let!(:robot) { Roboruby::Robot.new }

    it "should be a Robot module" do
      expect(Robot).to be Roboruby::Robot
    end

    context "#initialize" do

      it "is expected to be itialized with the position 0x0 by default" do
        new_robot = Roboruby::Robot.new
        expect(new_robot.report).to eq [0, 0, "NORTH"]
      end

      it "is expected to be itialized with the position 0x0 by default" do
        expect(robot.direction).to eq :north
      end

      it "is expected to be itialized a default board" do
        expect(robot.board).to_not be nil
      end

      it "is expected to be itialized a custom board" do
        board = Roboruby::Board.new({x: 10, y: 4, origin: 1})
        robot = Roboruby::Robot.new({board: board})
        expect(robot.board.x).to be 10
        expect(robot.board.y).to be 4
        expect(robot.board.origin).to be 1
      end

    end

    context "#set cell" do
      it "sets the value of cell based on the (x, y) coordinates" do
        expect(robot.place(2,2, "right")).to be(true)
      end

      it "should set the new position of the robot" do
        robot.place(2,2, "north")
        expect(robot.report).to eq [2, 2, "NORTH"]
      end

      it "returns nil if trying to use the command place with invalid coords" do
        expect(robot.place(345345,44, "right")).to be(nil)
      end

    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(robot.current_x).to be(0)
      end

      it "should also set the new position of the robot" do
        expect(robot.current_y).to be(0)
      end
    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(robot.current_x).to be(0)
      end

      it "should also set the new position of the robot" do
        expect(robot.current_y).to be(0)
      end
    end

    context "#move right" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        robot.right
        expect(robot.direction).to be(:east)
      end
    end

    context "#move left" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        robot.left
        expect(robot.direction).to be(:west)
      end

      it "should rotate the robot 360 degrees in the specified direction without changing the position" do
        4.times do
          robot.left
        end
        expect(robot.direction).to be(:north)
      end

      it "should rotate the robot 360 degrees 100 times" do
        400.times do
          robot.left
        end
        expect(robot.direction).to be(:north)
      end

      it "should rotate the robot 360 degrees 100 times and one to the right" do
        400.times do
          robot.left
        end
        robot.right
        expect(robot.direction).to be(:east)
      end
    end

    context "#move" do

      it "should return true" do
        robot.place(0,0, :north)
        expect(robot.move).to eq(true)
      end

      it "should move the robot one position further in the direction it is now" do
        robot.place(0,0, :north)
        robot.move
        expect(robot.report).to eq [0, 1, "NORTH"]
      end

      it "should not move the robot if the movement make it fall from the table" do
        robot.place(0,0, :south)
        expect(robot.move).to eq(nil)
      end
    end

    context "#movements should return the new position of the robot" do
      context "#move pointing different directions" do
        it "should move a step down" do
          robot.place(0,0, :south)
          expect(robot.movements[robot.direction]).to eq ([{:x=>0, :y=>-1, :direction => robot.direction}])
        end
        it "should move a step up" do
          robot.place(0,0, :north)
          expect(robot.movements[robot.direction]).to eq ([{:x=>0, :y=>1, :direction => robot.direction}])
        end
        it "should move a step to the right" do
          robot.place(2,2, :west)
          expect(robot.movements[robot.direction]).to eq ([{:x=>1, :y=>2, :direction => robot.direction}])
        end
        it "should move a step to the left" do
          robot.place(2,2, :east)
          expect(robot.movements[robot.direction]).to eq ([{:x=>3, :y=>2, :direction => robot.direction}])
        end
      end

      context "right/left pointing :south" do
        it "move left/right when poiting in one direction" do
          expect(robot.movements[:left].first[:south]).to eq :east
          expect(robot.movements[:right].first[:south]).to eq :west
        end
      end

      context "right/left pointing :east" do
        it "move left/right when poiting in one direction" do
          expect(robot.movements[:left].first[:east]).to eq :north
          expect(robot.movements[:right].first[:east]).to eq :south
        end
      end

      context "right/left pointing :north" do
        it "move left/right when poiting in one direction" do
          expect(robot.movements[:left].first[:north]).to eq :west
          expect(robot.movements[:right].first[:north]).to eq :east
        end
      end

      context "right/left pointing :west" do
        it "move left/right when poiting in one direction" do
          expect(robot.movements[:left].first[:west]).to eq :south
          expect(robot.movements[:right].first[:west]).to eq :north
        end
      end

      context "right/left pointing :east" do
        it "move left/right when poiting in one direction" do
          expect(robot.movements[:left].first[:east]).to eq :north
          expect(robot.movements[:right].first[:east]).to eq :south
        end
      end
    end

    context "#report" do
      it "should show the position of the robot" do
        x = rand(0..4)
        y = rand(0..4)
        f = %i(NORTH SOUTH EAST WEST).sample
        robot.place(x,y, f)
        expect(robot.report).to eq [x, y, f.to_s.upcase]
      end
    end

    context "#is in the grid?" do
      it "should be in the grid by default" do
        new_robot = Roboruby::Robot.new
        is_inside = new_robot.in_grid?
        expect(is_inside).to eq(true)
      end

      it "should not be possibile to be outside of the grid, ignore the movement" do
        robot.place(rand(5..990),rand(5..990), %i(NORTH SOUTH EAST WEST).sample)
        is_still_inside = robot.in_grid?
        expect(is_still_inside).to eq(true)
      end
    end

  end
end
