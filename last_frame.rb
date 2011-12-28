require 'frame'
class LastFrame < Frame
  def score
    sum_of_rolls
  end

  def complete?
    (strike? || spare?) ? @rolls.count == 3 : @rolls.count == 2
  end

  private
  
  def check
    raise FrameError if first_two_rolls_score > 10 and not strike?
  end
end
