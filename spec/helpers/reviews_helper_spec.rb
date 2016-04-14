require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  describe "display_time" do
    it "displays when the review is created relative to now" do
      now = Time.parse("2016-04-14 18:02:25 +0100")
      allow(Time).to receive(:now).and_return(now)
    end
  end
end
