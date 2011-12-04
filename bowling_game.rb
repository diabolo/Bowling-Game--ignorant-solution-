require 'frame'

class BowlingGame
  def initialize
    @frames=[]
    @current_frame=Frame.new
    @extras = 0
    @spare
    @strike
  end

  def roll(pins)
    raise ArgumentError unless (0..10).include?(pins)
    raise GameComplete if game_complete?
    @current_frame.roll pins
    new_frame if @current_frame.full? || @current_frame.strike?
  end

  def new_frame
    score_extras
    @frames << @current_frame
    @current_frame=Frame.new
  end

  def score_extras
    @extras += @current_frame.first_roll if spare?
    @extras += @current_frame.score if strike?
  end

  def spare?
    @frames.last.spare? rescue false
  end

  def strike?
    @frames.last.strike? rescue false
  end

  def score
    raise IncompleteGame unless game_complete?
    @frames.inject(0){|sum, v| sum += v.score} + @extras
  end

  def game_complete?
    @frames.count == 10
  end
end

class GameComplete < Exception
end
class IncompleteGame < Exception
end
