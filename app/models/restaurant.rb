class Restaurant < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def average_rating
    return 'N/A' if reviews.none?
    return case reviews.average(:rating).to_i
      when 1 then "★☆☆☆☆"
      when 2 then "★★☆☆☆"
      when 3 then "★★★☆☆"
      when 4 then "★★★★☆"
      when 5 then "★★★★★"
    end
  end
end
