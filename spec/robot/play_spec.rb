require 'spec_helper'

module Roboruby
  describe Play do
    
    let!(:robot) { Roboruby::Robot.new }
    let!(:play) { Play.new({robot: robot}) }
    let!(:valid_commands) { %w(RIGHT LEFT REPORT PLACE) }
    let!(:not_valid_commands) { %w(pla p 4 cis 55 % 3434 ; .. + * place) }

    it "should be a Robot module" do
      expect(Play).to be Roboruby::Play
    end

    it "should start the robot and initiate the table" do
      expect(play.robot).to be robot
    end

    context "#get_move with valid commands" do

      it "converts human_move of 'RIGHT'  to right" do
        play.get_move('RIGHT')
        expect(play.robot.direction).to eq :east
      end

      it "converts human_move of 'LEFT'  to left" do
        play.get_move('LEFT')
        expect(play.robot.direction).to eq :west
      end

      it "converts human_move of 'REPORT' to report" do
        expect(play.get_move('REPORT')).to eq [0, 0, "NORTH"]
      end

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        play.get_move('PLACE 2,3,NORTH')
        expect(play.robot.direction).to eq :north
      end

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        play.get_move('PLACE 2,3,NORTH')
        expect(play.robot.direction).to eq :north
      end

      it "converts MOVE to move" do
        play.get_move('PLACE 0,0,NORTH')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [0, 1, "NORTH"]
        #Output: 0,1,NORTH
      end
    end

    context "#get_move with valid commands" do
      it "should return false" do
        not_valid_commands.each do |c|
          expect(play.get_move(c)).to be nil
        end
      end
    end

    context "#parse command" do
      it "should set the command type if valid" do
        play.parse_command!('PLACE 2,3,NORTH')
        expect(play.command_x).to eq 2
        expect(play.command_y).to eq 3
        expect(play.command_f).to eq "NORTH"
      end

      it "should set the command type to nil if not valid" do
        play.parse_command!('PLACID 2,3,NORTH')
        expect(play.command).to eq nil
      end
    end

    context "#extract arguments" do
      it "should extract the arguments from the command and assign them" do
        play.extract_arguments!('2,3,NORTH')
        expect(play.command_x).to eq 2
        expect(play.command_y).to eq 3
        expect(play.command_f).to eq "NORTH"
      end
    end

    context "#is a valid command? with valid commands" do

      it "should return true for 'PLACE x,y,f'" do
        valid = play.is_valid_command?("PLACE 1,2,NORTH")
        expect(valid).to be true
      end

      it "should return true for a valid command" do
        valid_commands.each do |c|
          valid = play.is_valid_command?(c)
          expect(valid).to be true
        end
      end
    end

    context "#is a valid command? with invalid commands" do
      it "should return false for an invalid command" do
        not_valid_commands.each do |c|
          invalid = play.is_valid_command?(c)
          expect(invalid).to be nil
        end
      end
    end

    context "Do the demo set of commands from Specs" do
      it "example a)" do
        play.get_move('PLACE 0,0,NORTH')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [0, 1, "NORTH"]
        #Output: 0,1,NORTH
      end
      it "example b)" do
        play.get_move('PLACE 0,0,NORTH')
        play.get_move('LEFT')
        expect(play.robot.report).to eq [0, 0, "WEST"]
        #Output: 0,0,WEST
      end
      it "example c)" do
        play.get_move('PLACE 1,2,EAST')
        play.get_move('MOVE')
        play.get_move('MOVE')
        play.get_move('LEFT')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [3, 3, "NORTH"]
        #Output: 3,3,NORTH
      end
    end
  end
end
