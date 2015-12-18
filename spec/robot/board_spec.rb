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
    end
  end
end
