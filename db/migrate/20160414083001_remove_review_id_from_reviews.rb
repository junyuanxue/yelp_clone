class RemoveReviewIdFromReviews < ActiveRecord::Migration
  def change
    remove_reference :reviews, :review_id, :integer
  end
end
