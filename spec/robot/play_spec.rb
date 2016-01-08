require 'spec_helper'

module Roboruby
  describe Play do

    let!(:robot) { Roboruby::Robot.new }
    let!(:play) { Play.new({robot: robot}) }
    let!(:board) { Roboruby::Board.new  }
    let!(:valid_commands) { %w(RIGHT LEFT REPORT PLACE) }
    let!(:not_valid_commands) { %w(ciccio probldldjd eskudzbj qwsjdhbqwja sjsaddsajh ashdh hh) }

    it "should be a Robot module" do
      expect(Play).to be Roboruby::Play
    end

    it "should start the robot and initiate the table" do
      expect(play.robot).to be robot
    end

    context "#initialize" do
      it "should initialize the robot with a custom board" do
        robot = Roboruby::Robot.new({board: board})
        play = Play.new({robot: robot})
        expect(play.robot.board.object_id).to be board.object_id
      end
    end
    context "#get_move with valid commands" do

      it "converts human_move of 'RIGHT'  to right" do
        play.get_move('RIGHT')
        expect(play.robot.human_direction).to eq 'EAST'
      end

      it "converts human_move of 'LEFT'  to left" do
        play.get_move('LEFT')
        expect(play.robot.human_direction).to eq 'WEST'
      end

      it "converts human_move of 'REPORT' to report" do
        expect(play.get_move('REPORT')).to eq [0, 0, "NORTH"]
      end

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        play.get_move('PLACE 2,3,0')
        expect(play.robot.human_direction).to eq 'NORTH'
      end

      it "converts human_move of 'PLACE X,Y,F' to place(x,y,f)" do
        play.get_move('PLACE 2,3,0')
        expect(play.robot.human_direction).to eq 'NORTH'
      end

      it "converts MOVE to move" do
        play.get_move('PLACE 0,0,0')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [0, 1, "NORTH"]
        #Output: 0,1,NORTH
      end
    end

    context "#get_move with valid commands" do
      it "should return false" do
        not_valid_commands.each do |c|
          expect(play.get_move(c)).to include "doesn't know how to perform"
        end
      end
    end

    context "#parse command" do
      it "should set the command type if valid" do
        play.parse_command!('PLACE 2,3,NORTH')
        expect(play.command_x).to eq 2
        expect(play.command_y).to eq 3
        expect(play.command_f).to eq 0
      end

      it "should set the command type to nil if not valid" do
        play.parse_command!('PLACID 2,3,0')
        expect(play.command).to eq :placid
      end
    end

    context "#extract arguments" do
      it "should extract the arguments from the command and assign them" do
        play.extract_arguments!('2,3,NORTH')
        expect(play.command_x).to eq 2
        expect(play.command_y).to eq 3
        expect(play.command_f).to eq 0
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
      it "example d)" do
        play.get_move('PLACE 2,2,NORTHEAST')
        play.get_move('MOVE')
        play.get_move('MOVE')
        play.get_move('LEFT')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [4, 4, "NORTHWEST"]
        #Output: 4,4,NORTHWEST
      end
      it "example e)" do
        play.get_move('PLACE 1,2,SOUTHEAST')
        play.get_move('MOVE')
        play.get_move('MOVE')
        play.get_move('LEFT')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [4, 1, "NORTHEAST"]
        #Output: 4,1,NORTH
      end
      it "example f)" do
        play.get_move('PLACE 3,3,SOUTHWEST')
        play.get_move('MOVE')
        play.get_move('MOVE')
        play.get_move('LEFT')
        play.get_move('MOVE')
        expect(play.robot.report).to eq [2, 0, "SOUTHEAST"]
        #Output: 2,0,NORTH
      end
    end
  end
end
