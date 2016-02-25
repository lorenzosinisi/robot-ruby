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
      @allowed_actions = robot.methods(false)
    end

    # TODO check that the @command is actually one of the defined instance method of Robot
    # should not be able to call any other method except from those defined in the Class
    def get_move(cmd)
      @command, @command_x, @command_y, @command_f = parser.parse(cmd)
      # here we should check that the method that we are sending to the object is actually defined as
      # an allowed action. Methods of the object or his ancestors should not be accessible
      # use something as robot.custom_send(args) instead
      robot.send(@command, @command_x.to_i, @command_y.to_i, @command_f.to_i) # dangerous code
    end

  end
end
