require "blinkbox/tictoc"

context Blinkbox::CommonHelpers::TicToc do
  before :each do
    extend(described_class)
    tictoc_reset
  end

  describe "#tic" do    
    it "must return nil if never called before" do
      expect(tic).to be_nil
    end

    it "must return the time #tic was called previously" do
      t = Time.now
      tic
      sleep 0.1
      second_time = tic
      sleep 0.1
      expect(second_time.to_f - t.to_f).to be < 0.01
    end
  end

  describe "#toc (before calling #tic)" do
    it "must return nil" do
      expect(toc).to be_nil
    end
  end

  describe "#toc (after calling #tic)" do
    it "must return the number of milliseconds between the two callings" do
      t = Time.now
      tic
      sleep 0.5
      out = toc
      elapsed = (Time.now - t).to_f * 1000
      # The tests aren't great - we're okay with a millisecond out
      expect(out).to be_within(1).of(elapsed)
    end

    it "must keep two labels separate" do
      t = Time.now
      tic(:a)
      sleep 0.2
      tic(:b)
      sleep 0.2
      toc(:b)
      sleep 0.2
      out = toc(:a)
      elapsed = (Time.now - t).to_f * 1000
      expect(out).to be_within(1).of(elapsed)
    end
  end
end