require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  describe "display_time" do
    let!(:review) { Review.create(thoughts: "meh", rating: 1, created_at: Time.parse("2016-04-14 14:02:25 +0100")) }

    it "displays when the review is created relative to now" do
      now = Time.parse("2016-04-14 18:02:25 +0000")
      allow(Time).to receive(:now).and_return(now)
      expect(display_time(review)).to eq "4 hours ago"
    end
  end
end
