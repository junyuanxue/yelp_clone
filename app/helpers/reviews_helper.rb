module ReviewsHelper
  def display_time(review)
    puts "this is review: #{review.class}"
    p review
    puts "this is created: #{review.created_at.class}"
    p review.created_at
    puts "this is hour: #{review.created_at.hour.class}"
    p review.created_at.hour
    p Time.now.hour
    "#{pluralize(Time.now.hour - review.created_at.hour, hour)} ago"
  end
end
