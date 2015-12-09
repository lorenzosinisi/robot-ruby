require 'spec_helper'

module Robot
  describe Play do
    it "should be a Robot module" do 
      expect(Play).to be Robot::Play
    end
  end
end