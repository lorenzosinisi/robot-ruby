require 'spec_helper'

module Roboruby
  describe Board do
    it "should be a Robot module" do
      expect(Board).to be Roboruby::Board
    end
  end
end