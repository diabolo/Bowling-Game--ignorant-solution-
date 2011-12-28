class Frame
  UNDEFINED_SCORE = '-'

  def initialize
    @rolls=[]
    @extras = 0
  end

  def roll(pins)
    raise ArgumentError unless (0..10).include?(pins)
    raise FrameCompleteError if complete?
    @rolls << pins
    check
    self
  end
  
  def next_frame=(frame)
    @next_frame = frame
  end
  
  def complete?
    spare? || strike? || full?
  end

  def score
    sum_of_rolls + extras
  rescue FrameScoreIncomplete
    return UNDEFINED_SCORE
  rescue 
    return UNDEFINED_SCORE
  end

  protected
  
  def two_rolls_score
    if @rolls.count > 1
      first_two_rolls_score
    elsif @rolls.count == 1
      first_roll_score + @next_frame.one_roll_score
    else
      raise FrameScoreIncomplete
    end
  end

  def one_roll_score
    raise FrameScoreIncomplete unless @rolls.count > 0
    @rolls[0]
  end

  def spare?
    first_two_rolls_score==10 and not strike?
  end

  def strike?
    first_roll_score==10
  end

  def first_roll_score
    @rolls[0] || 0
  end

  def first_two_rolls_score
    first_roll_score + second_roll
  end

  private
  
  def sum_of_rolls
    @rolls.inject{|sum,v| sum +=v}
  end

  def full?
    @rolls.count == 2
  end
  
  def check
    raise FrameError if first_two_rolls_score > 10 
  end

  def second_roll
    @rolls[1] || 0
  end
  
  def extras
    extras? ? extras_score : 0
  end

  def extras?
    strike? || spare?
  end

  def extras_score
    raise FrameScoreIncomplete unless @next_frame
    strike? ? @next_frame.two_rolls_score : @next_frame.one_roll_score
  end

end



class FrameError < Exception
end
class FrameCompleteError < Exception
end
class FrameScoreIncomplete < Exception
end
