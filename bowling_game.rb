require 'frame'
require 'last_frame'

class BowlingGame

  NUM_FRAMES = 10

  def initialize
    @frames=[]
    @current_frame=Frame.new
  end

  def roll(pins)
    raise GameComplete if game_complete?
    @current_frame.roll pins
    new_frame if @current_frame.complete?
    self # so we can concatenate rolls
  end

  def score
    raise IncompleteGame unless game_complete?
    @frames.inject(0){|sum, v| sum += v.score}
  end

  private
  def new_frame
    save_current_frame
    unless game_complete?
      add_new_frame
    end
  end

  def save_current_frame
    @frames << @current_frame
  end

  def add_new_frame
    new_frame = last_frame? ? LastFrame.new : Frame.new
    @current_frame.next_frame = new_frame
    @current_frame = new_frame
  end
  
  def last_frame?
    @frames.count == NUM_FRAMES - 1
  end

  def game_complete?
    @frames.count == 10
  end
end

class GameComplete < Exception
end
class IncompleteGame < Exception
end
