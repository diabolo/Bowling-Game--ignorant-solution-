class Frame
  def initialize
    @rolls=[]
    @extras = 0
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
    @rolls.inject{|sum,v| sum +=v} + @extras
  end

  def score_extras(extras)
    if extras.is_a?(Fixnum)
      @extras += extras if strike?
    elsif extras.is_a?(Frame)
      @extras += extras.first_two_rolls if strike?
      @extras += extras.first_roll if spare?
    else
      raise ArgumentError
    end
  end

  def spare?
    first_two_rolls==10 and not strike?
  end

  def strike?
    first_roll==10
  end

  def first_roll
    @rolls[0]
  end

  def first_two_rolls
    first_roll + second_roll
  end

  private
  
  def full?
    @rolls.count == 2
  end
  
  def check
    raise FrameError if score > 10 
  end

  def second_roll
    @rolls[1] || 0
  end
end



class FrameError < Exception
end
