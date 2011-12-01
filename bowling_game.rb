class BowlingGame
  def initialize
    @frames=[]
    @current_frame=[]
  end

  def roll(pins)
    @current_frame << pins
    new_frame if frame_full?
  end

  def new_frame
    @frames << @current_frame
    @current_frame = []
  end

  def frame_full?
    @current_frame.count == 2
  end

  def score
    raise IncompleteGame unless game_complete?
    @frames.flatten.inject{|sum, v| sum += v}
  end

  def game_complete?
    @frames.count == 10
  end
end

class IncompleteGame < Exception
end
