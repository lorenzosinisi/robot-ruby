require 'spec_helper'

module Robot
  describe Play do
    before(:each) do
      @board = Robot::Board.new
      @play = Play.new({robot: @board})
    end

    it "should be a Robot module" do
      expect(Play).to be Robot::Play
    end

    it "should start the robot and initiate the table" do
      expect(@play.robot).to be @board
    end

    context "#get_move" do

      it "converts human_move of 'RIGHT'  to right" do
        @play.get_move('RIGHT')
        expect(@play.robot.direction).to eq "EAST"
      end

      it "converts human_move of 'LEFT'  to left" do
        @play.get_move('LEFT')
        expect(@play.robot.direction).to eq "WEST"
      end

      it "converts human_move of 'REPORT' to report" do
        expect(@play.get_move('REPORT')).to be true
      end

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        @play.get_move('PLACE 2,3,NORTH')
        expect(@play.robot.direction).to eq "NORTH"
      end
    end

    context "#is a valid command?" do
      it "should return true for 'RIGHT'" do
        valid = @play.is_valid_command?("RIGHT")
        expect(valid).to be true
      end

      it "should return true for 'LEFT'" do
        valid = @play.is_valid_command?('LEFT')
        expect(valid).to be true
      end

      it "should return true for 'REPORT'" do
        valid = @play.is_valid_command?('REPORT')
        expect(valid).to be true
      end

      it "should return true for kind of 'PLACE X,Y,F'" do
        ["NORTH", "WEST", "EAST", "SOUTH"].each do |dir|
          valid = @play.validate_place_command("PLACE 1,1," + dir)
          expect(valid).to be true
        end
      end

      it "should return false for an invalid command" do
        invalid = @play.is_valid_command?("PLACE 1,1,SOUT")
        expect(invalid).to be false
      end
    end

    context "#send place command" do
      it "should send the command to the board" do
        @play.send_place_command("PLACE 1,1,SOUTH")
        expect(@play.robot.report).to eq "1, 1, SOUTH"
      end

      it "should be able to call send place command more than once" do
        @play.send_place_command("PLACE 1,1,SOUTH")
        @play.send_place_command("PLACE 1,1,NORTH")
        @play.send_place_command("PLACE 1,3,WEST")
        @play.send_place_command("PLACE 4,3,EAST")
        expect(@play.robot.report).to eq "4, 3, EAST"
      end
    end

  end
end
