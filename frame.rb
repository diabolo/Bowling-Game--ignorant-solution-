class Frame
  def initialize
    @rolls=[]
  end

  def roll(pins)
    @rolls << pins
    check
  end
  
  def check
    raise FrameError if score > 10 
  end
  
  def full?
    @rolls.count == 2
  end

  def score
    @rolls.inject{|sum,v| sum +=v}
  end
end


