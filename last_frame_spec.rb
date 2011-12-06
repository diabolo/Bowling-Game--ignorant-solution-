require 'last_frame'
describe LastFrame do
  context "first roll is a strike" do 
    it "should not be_complete" do
      LastFrame.new.roll(10).should_not be_complete
    end
  end

  context "first two rolls are a double" do
    it "should not be complete" do 
      LastFrame.new.roll(10).roll(10).should_not be_complete
    end
  end

  context "first two rolls are a spare" do
    let(:frame){LastFrame.new.roll(0).roll(10)}
    it "should not be complete" do
      frame.should_not be_complete
    end

    it "should be complete after third roll" do
      frame.roll(0)
      frame.should be_complete
    end
  end

  context "first two rolls score < 10" do
    it "should be complete" do
      LastFrame.new.roll(4).roll(4).should be_complete
    end
  end
end
