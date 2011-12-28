require 'frame'
require 'last_frame'

class BowlingGame

  NUM_FRAMES = 10

  def initialize
    @frames=[]
    @current_frame=Frame.new
    @spare
    @strike
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

  #def score_extras
    #@frames[-2].score_extras(@current_frame.first_roll_score) if last_2_rolls_strikes?
    #@frames[-1].score_extras(@current_frame) if @frames[-1]
  #end

  def last_2_rolls_strikes?
    @frames[-2].strike? && @frames[-1].strike? rescue false
  end

  def spare?
    @frames.last.spare? rescue false
  end

  def strike?
    @frames.last.strike? rescue false
  end

  def game_complete?
    @frames.count == 10
  end
end

class GameComplete < Exception
end
class IncompleteGame < Exception
end
