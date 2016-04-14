class AddUserIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :review, index: true, foreign_key: true
  end
end
