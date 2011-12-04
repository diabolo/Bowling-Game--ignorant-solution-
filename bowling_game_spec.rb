require 'bowling_game'
module GameHelper
  def gutterball_game
    game = BowlingGame.new
    20.times{game.roll(0)}
    game
  end
end

describe BowlingGame do
  include GameHelper
  let(:game){BowlingGame.new}
  describe '#score' do
    it "should raise if game is incomplete" do
      expect{game.score}.to raise_error IncompleteGame
    end
  end

  describe '#roll' do 
    it "should raise if pins > 10" do
      expect{game.roll(11)}.to raise_error ArgumentError
    end

    it "should raise if pins > 10 for a frame" do
      expect do
        game.roll 5
        game.roll 6
      end.to raise_error FrameError
    end

    it "should not raise if two consecutive rolls in seperate frames are > 10" do
      expect do
        game.roll 3
        game.roll 6
        game.roll 7
      end.to_not raise_error FrameError
    end

    it "should raise if game is complete" do
      expect do 
        21.times{game.roll 0}
      end.to raise_error GameComplete
    end
  end

  context "gutterball game" do
    subject {gutterball_game.score}
    it "should score 0" do 
      should == 0
    end
  end

  context "game without strikes or spares" do
    (1..4).each do |num|
      it "with 20 rolls of #{num} should score #{20 * num}" do
        20.times{game.roll(num)}
        game.score.should == 20 * num
      end
    end
  end

  context "scoring extras for spares" do
    it "should add next roll bonus for a spare" do
      game.roll 0
      game.roll 10
      game.roll 5
      17.times{game.roll 0}
      game.score.should == 20
    end
  end

  context "scoring for strikes" do 
    it "should score a strike" do 
      game.roll 10
      18.times{game.roll 0}
      game.score.should == 10
    end

    it "should add next two rolls bonus for a strike" do
      game.roll 10
      game.roll 2
      game.roll 3
      16.times{game.roll 0}
      game.score.should == 20
    end

    it "should score a double correctly" do
      game.roll(10).roll(10).roll(4).roll(2)
      14.times{game.roll(0)}
      game.score.should == 46
    end
  end

end
