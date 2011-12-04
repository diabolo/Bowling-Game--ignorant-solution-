class Frame
  def initialize
    @rolls=[]
  end

  def roll(pins)
    @rolls << pins
    check
    self
  end
  
  def complete?
    spare? || strike? || full?
  end

  def score
    @rolls.inject{|sum,v| sum +=v}
  end

  def spare?
    score==10 && full?
  end

  def strike?
    score==10 && !full?
  end

  def first_roll
    @rolls[0]
  end

  private
  
  def full?
    @rolls.count == 2
  end
  
  def check
    raise FrameError if score > 10 
  end

end


class FrameError < Exception
end
