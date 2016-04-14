module ReviewsHelper
  def display_time(review)
    time_diff = pluralize(Time.now.hour - (review.created_at.hour + 1), "hour")
    "#{time_diff} ago"
  end
end
