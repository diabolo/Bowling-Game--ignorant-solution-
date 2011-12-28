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

describe "Frame.score" do
  include FrameRollerHelper
  context "no rolls" do
    it "should be undefined" do
      Frame.new.score.should == Frame::UNDEFINED_SCORE
    end
  end

  context "strike" do
    let(:frame){roll_strike}
    
    context "no next_frame" do
      it "should be undefined" do 
        frame.score.should == Frame::UNDEFINED_SCORE
      end
    end

    context "next frame strike" do
      before :each do
        @next_frame = roll_strike
        frame.next_frame = @next_frame
      end
        
      context "no subsequent frame" do 
        it "should be undefined" do 
          frame.score.should == Frame::UNDEFINED_SCORE
        end
      end
      
      context "subsequent frame strike" do
         it "should be 30" do
           subsequent_frame = roll_strike
           @next_frame.next_frame = subsequent_frame
           frame.score.should == 30
         end
      end
    end

    context "next frame spare" do
      it "should be 20" do
        next_frame = roll_spare
        frame.next_frame = next_frame
        frame.score.should == 20
      end
    end
    
    context "next frame [3,5]" do
      it "should be 18" do
        next_frame = Frame.new.roll(3).roll(5)
        frame.next_frame = next_frame
        frame.score.should == 18
      end
    end
  end
    
  context "spare" do
    let(:frame){roll_spare}
    
    context "no next frame" do
      it "should be undefined" do
        frame.score.should == Frame::UNDEFINED_SCORE
      end
    end

    context "next frame" do
      it "should add the next frames first roll" do
        frame.next_frame = roll_strike
        frame.score.should == 20
      end
    end
  end

  context "otherwise" do 
    it "should be the sum of the two rolls" do
      Frame.new.roll(3).roll(5).score.should == 8
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
