require 'spec_helper'

module Roboruby
  describe Board do
    let!(:board) { Roboruby::Board.new }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Board).to be Roboruby::Board
      end
      it "have x and y by default" do
        expect(board.width).to be 4
        expect(board.height).to be 4
      end
    end

    context "#initialize with options" do
      it "should initialize the options" do
        width, height, origin = rand(0..100), rand(0..100), rand(0..100)
        board_with_options = Roboruby::Board.new({width: width, height: height, origin: origin })
        expect(board_with_options.width).to be width
        expect(board_with_options.height).to be height
      end
    end

  end
end
