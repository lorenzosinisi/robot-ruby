require 'spec_helper'

module Robot
  describe Board do

    let!(:board) { Robot::Board.new }

    it "should be a Robot module" do
      expect(Board).to be Robot::Board
    end

    context "#initialize" do

      it "is expected to be itialized with the position 0x0 by default" do
        expect(board.current_x).to be(0)
        expect(board.current_y).to be(0)
      end

      it "is expected to be itialized with the position 0x0 by default" do
        expect(board.direction).to eq :north
      end
    end

    context "#set cell" do
      it "sets the value of cell based on the (x, y) coordinates" do
        expect(board.place(2,2, "right")).to be(true)
      end

      it "returns nil if trying to use the command place with invalid coords" do
        expect(board.place(345345,44, "right")).to be(nil)
      end

      it "should also set the new position of the robot" do
        board.place(2,2, "north")
        expect(board.report).to eq [2, 2, "NORTH"]
      end
    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(board.current_x).to be(0)
      end

      it "should also set the new position of the robot" do
        expect(board.current_y).to be(0)
      end
    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(board.current_x).to be(0)
      end

      it "should also set the new position of the robot" do
        expect(board.current_y).to be(0)
      end
    end

    context "#move right" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        board.right
        expect(board.direction).to be(:east)
      end
    end

    context "#move left" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        board.left
        expect(board.direction).to be(:west)
      end
      
      it "should rotate the robot 360 degrees in the specified direction without changing the position" do
        4.times do
          board.left
        end
        expect(board.direction).to be(:north)
      end

      it "should rotate the robot 360 degrees 100 times" do
        400.times do
          board.left
        end
        expect(board.direction).to be(:north)
      end

      it "should rotate the robot 360 degrees 100 times and one to the right" do
        400.times do
          board.left
        end
        board.right
        expect(board.direction).to be(:east)
      end
    end

    context "#move" do
      
      it "should return true" do
        board.place(0,0, :north)
        expect(board.move).to eq(true)
      end

      it "should move the robot one position further in the direction it is now" do
        board.place(0,0, :north)
        board.move
        expect(board.report).to eq [0, 1, "NORTH"]
      end

      it "should not move the robot if the movement make it fall from the table" do
        board.place(0,0, :south)
        expect(board.move).to eq(nil)
      end
    end

    context "#report" do
      it "should show the position of the robot" do
        x = rand(0..4)
        y = rand(0..4)
        f = %i(NORTH SOUTH EAST WEST).sample
        board.place(x,y, f)
        expect(board.report).to eq [x, y, f.to_s.upcase]
      end
    end

    context "#is in the grid?" do
      it "should be in the grid by default" do
        new_board = Robot::Board.new
        is_inside = new_board.in_grid?
        expect(is_inside).to eq(true)
      end

      it "should not be possibile to be outside of the grid, ignore the movement" do
        board.place(rand(5..990),rand(5..990), %i(NORTH SOUTH EAST WEST).sample)
        is_still_inside = board.in_grid?
        expect(is_still_inside).to eq(true)
      end
    end

  end
end
