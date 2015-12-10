require 'spec_helper'

module Robot
  describe Play do
    before(:each) do 
      @board = Robot::Board.new
      @play = Play.new({table: @board})
    end
    
    it "should be a Robot module" do 
      expect(Play).to be Robot::Play
    end
    
    it "should start the robot and initiate the table" do
      expect(@play.table).to be @board
    end
    
    context "#get_move" do
      it "converts human_move of 'RIGHT'  to right" do
      end
      it "converts human_move of 'LEFT'  to left"
      it "converts human_move of 'REPORT' to report"
      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)"
    end

    context "#is a valid command?" do
      it "should return true for 'RIGHT'" do
        valid = @play.is_valid_command?("RIGHT")
        expect(valid).to be true
      end

      it "should return true for 'LEFT'"
      it "should return true for 'REPORT'"
      it "should return true for kind of 'PLACE X,Y,F'"
      it "should return false for anything else"
    end

  end
end