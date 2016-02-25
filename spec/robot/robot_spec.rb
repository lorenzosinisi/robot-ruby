require 'spec_helper'

module Roboruby
  describe Robot do

    let!(:robot) { Roboruby::Robot.new }
    let!(:compass) { Roboruby::Compass.new }
    
    it "should be a Robot module" do
      expect(Robot).to be Roboruby::Robot
    end

    context "#initialize" do

      it "is expected to be itialized with the position 0x0 by default" do
        new_robot = Roboruby::Robot.new
        expect(new_robot.report).to eq [0, 0, "NORTH"]
      end

      it "is expected to be itialized with the position 0x0 by default" do
        expect(robot.report).to eq([0, 0, "NORTH"])
      end

      it "is expected to be itialized a default board" do
        expect(robot.board).to_not be nil
      end

      it "is expected to be itialized a custom board" do
        board = Roboruby::Board.new({width: 10, height: 4, origin: 1})
        robot = Roboruby::Robot.new({board: board})
        expect(robot.board.width).to be 10
        expect(robot.board.height).to be 4
      end

    end

    context "#set cell" do
      it "sets the value of cell based on the (x, y) coordinates" do
        expect(robot.place(2,2, 0)).to eq([2, 2, "NORTH"])
      end

      it "should set the new position of the robot" do
        robot.place(2,2, 0)
        expect(robot.report).to eq [2, 2, "NORTH"]
      end

      it "returns nil if trying to use the command place with invalid coords" do
        expect(robot.place(345345,44, "right")).to eq("Attempt to move into an invalid position")
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

    # TODO don't hardcore the output but read it directly from the map
    context "#move right" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        robot.right
        expect(robot.report).to eq([0, 0, "EAST"])
      end
    end
    # TODO don't hardcore the output but read it directly from the map
    context "#move left" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        robot.left
        expect(robot.report).to eq([0, 0, "WEST"])
      end

      it "should rotate the robot 360 degrees in the specified direction without changing the position" do
        4.times do
          robot.left
        end
        expect(robot.report).to eq([0, 0, "NORTH"])
      end

      it "should rotate the robot 360 degrees 100 times" do
        400.times do
          robot.left
        end
        expect(robot.report).to eq([0, 0, "NORTH"])
      end

      it "should rotate the robot 360 degrees 100 times and one to the right" do
        400.times do
          robot.left
        end
        robot.right
        expect(robot.report).to eq([0, 0, "EAST"])
      end
    end

    context "#move" do

      it "should return true" do
        robot.place(0,0, 0)
        expect(robot.move).to eq([0, 1, "NORTH"])
      end

      it "should move the robot one position further in the direction it is now" do
        robot.place(0,0, 0)
        robot.move
        expect(robot.report).to eq [0, 1, "NORTH"]
      end

      it "should not move the robot if the movement make it fall from the table" do
        robot.place(0,0, 180)
        expect(robot.move).to eq("Attempt to move into an invalid position")
      end
    end

    context "#report" do
      it "should show the position of the robot" do
        x = rand(0..4)
        y = rand(0..4)
        f = rand(0..360)
        dir = compass.grad_to_direction(f)
        robot.place(x, y, f)
        expect(robot.report).to eq [x, y, dir.upcase.to_s]
      end
    end

    context "#is in the grid?" do
      it "should be in the grid by default" do
        new_robot = Roboruby::Robot.new
        is_inside = new_robot.can_i_move?(new_robot.current_x, new_robot.current_y)
        expect(is_inside).to eq(true)
      end

      it "should not be possibile to be outside of the grid, ignore the movement" do
        board_size = Board.new.size
        robot.place rand((board_size + 1)..(board_size + 900)), # random bigger X
                    rand((board_size + 1)..(board_size + 900)), # random bigger Y
                    %i(NORTH SOUTH EAST WEST).sample            # random correct direction

        expect([robot.current_x, robot.current_y]).to eq([0,0])
      end
    end

    describe ".method_missing" do
      it "should always tell that the robot can't perform the action required" do
        expect( robot.send("robot_action_#{srand}".to_sym) ).to include "doesn't know how to perform"
      end
    end

  end
end
