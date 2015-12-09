require 'spec_helper'

module Robot
  describe Board do
    it "should be a Robot module" do 
      expect(Board).to be Robot::Board
    end
    
    context "#initialize" do
      it "is expected to be itialized with a 2d array of 5x5 by default" do
        board = Robot::Board.new
        expect(board.grid).to eq Array.new(5) { Array.new(5) {  }  }
      end

      it "is expected to be itialized with the position 0x0 by default" do
        board = Robot::Board.new
        expect(board.position).to eq [0,0]
      end

      it "is expected to be itialized with the position 0x0 by default" do
        board = Robot::Board.new
        expect(board.direction).to eq "south"
      end
    end

    context "#get cell" do
      it "returns the cell based on the (x, y) coordinates" do
        board = Robot::Board.new
        expect(board.get_cell(2,2)).to eq(nil)
      end
    end

    context "#set cell" do
      it "sets the value of cell based on the (x, y) coordinates" do
        board = Robot::Board.new
        expect(board.set_cell(2,2, "right")).to eq("right")
      end
    end

  end
end