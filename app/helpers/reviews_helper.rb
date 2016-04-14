module ReviewsHelper
  def display_time(review)
    p review.created_at
    "#{pluralize(Time.now.hour - (review.created_at.hour + 1), "hour")} ago"
  end
end
