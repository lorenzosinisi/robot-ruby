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

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        @play.get_move('PLACE 2,3,NORTH')
        expect(@play.robot.direction).to eq "NORTH"
      end
    end

    context "#parse command" do
      it "should set the command type if valid" do
        @play.parse_command('PLACE 2,3,NORTH')
        expect(@play.command_type).to eq :place
        expect(@play.command_x).to eq 2
        expect(@play.command_y).to eq 3
        expect(@play.command_f).to eq "NORTH"
      end

      it "should set the command type to nil if not valid" do
        @play.parse_command('PLACID 2,3,NORTH')
        expect(@play.command_type).to eq nil
      end

      it "should set the command type to nil if not valid" do
        @play.parse_command('PLACID 2,3,NORTH')
        expect(@play.command_type).to eq nil
      end
    end

    context "#extract arguments" do
      it "should extract the arguments from the command" do
        @play.extract_arguments('2,3,NORTH')
        expect(@play.command_x).to eq 2
        expect(@play.command_y).to eq 3
        expect(@play.command_f).to eq "NORTH"
      end
    end

    context "#is a valid command?" do

      it "should return true for 'PLACE'" do
        valid = @play.is_valid_command?("PLACE 1,2,NORTH")
        expect(valid).to be true
      end

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

      it "should return false for an invalid command" do
        invalid = @play.is_valid_command?("PLACE 1,1,SOUT")
        expect(invalid).to be true
      end
    end

  end
end
