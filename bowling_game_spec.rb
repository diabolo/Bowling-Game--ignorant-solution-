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
end
