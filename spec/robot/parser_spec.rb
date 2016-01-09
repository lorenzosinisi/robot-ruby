require 'spec_helper'

module Roboruby
  describe Parser do
    subject { Roboruby::Parser.new }
    context "#initialize" do
      it "should be a Robot module" do
        expect(Parser).to be Roboruby::Parser
      end
    end

    context "#parse" do
      context "returns the valid command with the params for:" do
        it "move" do 
          expect(subject.parse("MOVE")).to eq [:move]
        end
        it "right" do
          expect(subject.parse("RIGHT")).to eq [:right]
        end
        it "left" do
          expect(subject.parse("LEFT")).to eq [:left]
        end
        it "report" do
          expect(subject.parse("REPORT")).to eq [:report]
        end
        it "place" do
          expect(subject.parse("PLACE 1,1,NORTH")).to eq [:place, 1, 1, 0]
        end
      end
    end

  end
end
