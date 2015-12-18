require 'spec_helper'

module Roboruby
  describe Board do
    let!(:board) { Roboruby::Board.new }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Board).to be Roboruby::Board
      end
      it "have x and y by default" do
        expect(board.x).to be 4
        expect(board.y).to be 4
      end
      it "the origin should be 0 by default" do
        expect(board.origin).to be 0
      end
    end

    context "#initialize with options" do
      it "should initialize the options" do
        x, y, origin = rand(0..100), rand(0..100), rand(0..100)
        board_with_options = Roboruby::Board.new({x: x, y: y, origin: origin })
        expect(board_with_options.x).to be x
        expect(board_with_options.y).to be y
        expect(board_with_options.origin).to be origin
      end
    end

  end
end
