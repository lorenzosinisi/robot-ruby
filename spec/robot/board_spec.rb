require 'spec_helper'

module Robot
  describe Board do

    before(:each) do
      @board  = Robot::Board.new
    end

    it "should be a Robot module" do
      expect(Board).to be Robot::Board
    end

    context "#initialize" do

      it "is expected to be itialized with the position 0x0 by default" do
        expect(@board.position).to eq [0,0]
      end

      it "is expected to be itialized with the position 0x0 by default" do
        expect(@board.direction).to eq "NORTH"
      end
    end


    context "#set cell" do
      it "sets the value of cell based on the (x, y) coordinates" do
        expect(@board.set_cell(2,2, "right")).to eq true
      end

      it "sets the value of a cell that is not on the grid" do
        expect(@board.set_cell(345345,44, "right")).to eq false
      end

      it "should also set the new position of the robot" do
        @board.set_cell(2,2, "right")
        expect(@board.position).to eq [2,2]
      end
    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(@board.current_x).to eq(0)
      end

      it "should also set the new position of the robot" do
        expect(@board.current_y).to eq(0)
      end
    end

    context "#current x and current y" do
      it "returns the current x" do
        expect(@board.current_x).to eq(0)
      end

      it "should also set the new position of the robot" do
        expect(@board.current_y).to eq(0)
      end
    end

    context "#move right" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        @board.move_right
        expect(@board.direction).to eq("EAST")
      end
    end

    context "#move left" do
      it "should rotate the robot 90 degrees in the specified direction without changing the position" do
        @board.move_left
        expect(@board.direction).to eq("WEST")
      end
      it "should rotate the robot 360 degrees in the specified direction without changing the position" do
        4.times do
          @board.move_left
        end
        expect(@board.direction).to eq("NORTH")
      end

      it "should rotate the robot 360 degrees 100 times" do
        400.times do
          @board.move_left
        end
        expect(@board.direction).to eq("NORTH")
      end

      it "should rotate the robot 360 degrees 100 times and one to the right" do
        400.times do
          @board.move_left
        end
        @board.move_right
        expect(@board.direction).to eq("EAST")
      end
    end

    context "#move" do
      it "should move the robot one position further in the direction it is now" do
        @board.set_cell(0,0, "NORTH")
        expect(@board.move).to eq true
        expect(@board.position).to eq([0,1])

        expect(@board.move).to eq true
        expect(@board.position).to eq([0,2])

        #@board.set_cell(2,2, "WEST")
        #expect(@board.move).to eq true
        #expect(@board.position).to eq([3,2])

        #@board.set_cell(2,2, "EAST")
        #expect(@board.move).to eq true
        #expect(@board.position).to eq([1,2])
      end

      it "should not move the robot if the movement make it fall from the table" do
        @board.set_cell(0,0, "NORTH")
        expect(@board.move).to eq true
      end
    end

    context "#report" do
      it "should print the position of the robot" do
        expect(@board.report).to eq "0, 0, NORTH"
      end
    end

    context "#is on the grid?" do
      it "should be in the grid by default" do
        is_inside = @board.in_grid?
        expect(is_inside).to eq true
      end

      it "should not be possibile to be outside of the grid" do
        @board.set_cell(4343,43243, "right")
        is_inside = @board.in_grid?
        expect(is_inside).to eq true
        # so not moved outside of the grid and ignored the command set_cell
      end
    end

  end
end
