class LastFrame < Frame
  def complete?
    (strike? || spare?) ? @rolls.count == 3 : @rolls.count == 2
  end


  def strike?
    @rolls[0] == 10
  end
  
  def spare?
    @rolls[0] != 10 && @rolls.count == 2 && @rolls[0] + @rolls[1] == 10
  end
  
  def check
  end
end
