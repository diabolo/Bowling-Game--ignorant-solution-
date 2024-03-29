require 'frame'
class LastFrame < Frame
  def complete?
    (strike? || spare?) ? @rolls.count == 3 : @rolls.count == 2
  end

  private
  
  def check
    raise FrameError if first_two_rolls > 10 and not strike?
  end
end
