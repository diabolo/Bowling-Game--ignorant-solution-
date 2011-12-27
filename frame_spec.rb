require 'frame'

describe Frame do
  context "strike" do
    let(:frame){Frame.new.roll(10)}
    it "should be a strike" do
      frame.should be_strike
    end

    it "should not be a spare" do 
      frame.should_not be_spare
    end

    context "score extras" do
      before {frame.score_extras(5)}
      it "should still be a strike" do
        frame.should be_strike
      end
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

describe "Frame.score_extras" do
  let(:frame){Frame.new.roll(3).roll(4)}
  it "should not score unless a spare or strike" do
    expect{frame.score_extras(5)}.not_to change{frame.score}
  end

  context "passed a score" do
    context "frame is a spare" do
      let(:frame){Frame.new.roll(0).roll(10)}
      it "should not score" do
        expect{frame.score_extras(5)}.not_to change{frame.score}
      end
    end
    context "frame is a strike" do
      let(:frame){Frame.new.roll(10)}
      it {expect{frame.score_extras(5)}.to change{frame.score}}
    end
  end

  context "frame is a strike" do 
    context "passed a frame" do 
      let(:frame){Frame.new.roll(10)}
      let(:extras){Frame.new.roll(5).roll(5)}
      it "should add the passed frames score" do
        expect{frame.score_extras(extras)}.to change{frame.score}.from(10).to(20)
      end
    end
  end

  context "frame is a spare" do 
    context "passed a frame" do
      let(:frame){Frame.new.roll(5).roll(5)}
      let(:extras){Frame.new.roll(3).roll(6)}
      it "should add the passed frames first roll" do
        expect{frame.score_extras(extras)}.to change{frame.score}.from(10).to(13)
      end
    end
  end
end

describe "Frame.roll" do
  it "should raise if frame is complete" do
    frame = Frame.new.roll(5).roll(3)
    frame.should be_complete
    expect{frame.roll(0)}.to raise_error FrameCompleteError
  end
end
