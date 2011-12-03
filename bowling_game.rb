require 'frame'

class BowlingGame
  def initialize
    @frames=[]
    @current_frame=Frame.new
  end

  def roll(pins)
    raise ArgumentError unless (0..10).include?(pins)
    raise GameComplete if game_complete?
    @current_frame.roll pins
    new_frame if @current_frame.full?
  end

  def new_frame
    @frames << @current_frame
    @current_frame=Frame.new
  end

  def score
    raise IncompleteGame unless game_complete?
    @frames.inject(0){|sum, v| sum += v.score}
  end

  def game_complete?
    @frames.count == 10
  end
end

class GameComplete < Exception
end
class IncompleteGame < Exception
end
class FrameError < Exception
end
