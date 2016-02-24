module Roboruby
  class Play

    attr_reader :robot, :name, :parser
    # saving command issued by human in order
    # to be able to create a kind of "reverse" method in the future
    attr_accessor :command, :command_x, :command_y, :command_f

    def initialize(options={})
      @board  =  options[:board] || Roboruby::Board.new
      @robot  =  options[:robot] || Roboruby::Robot.new({board: @board, compass: @compass})
      @parser =  Parser.new
      @name   =  options[:name] || object_id
      @command, @command_x, @command_y, @command_f = :report, 0, 0, 0
    end

    def get_move(cmd)
      @command, @command_x, @command_y, @command_f = parser.parse(cmd)
      robot.send(@command, @command_x.to_i, @command_y.to_i, @command_f.to_i)
    end

  end
end
