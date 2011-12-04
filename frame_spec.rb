require 'frame'

describe Frame do
  context "one roll of 10" do
    let(:frame){Frame.new.roll(10)}
    it "should be a strike" do
      frame.should be_strike
    end

    it "should not be a spare" do 
      frame.should_not be_spare
    end
  end

  context "spare" do
    let(:frame){Frame.new}
    [
      '[0,10]',
      '[1,9]',
      '[2,8]',
      '[3,7]',
      '[4,6]',
      '[5,5]',
      '[6,4]',
      '[7,3]',
      '[8,2]',
      '[9,1]',
    ].each do |rolls|
      it "rolls of #{rolls} should be a spare" do
        eval(rolls).each do |pins|
          frame.roll(pins)
        end
        frame.should be_spare
      end

      it "rolls of #{rolls} should not be a strike" do
        eval(rolls).each do |pins|
          frame.roll(pins)
        end
        frame.should_not be_strike
      end
    end
  end
end

module FrameRollerHelper
  def roll_strike
    Frame.new.roll(10)
  end
  def roll_spare
    Frame.new.roll(3).roll(7)
  end
  def roll_full
    Frame.new.roll(0).roll(0)
  end
end
describe "Frame.complete?" do
  include FrameRollerHelper
  %w(spare strike full).each do |condition|
    it "should be true if #{condition}" do
      eval("roll_#{condition}").should be_complete
    end
  end
end
