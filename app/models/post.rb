class Post < ApplicationRecord

  has_one_attached :featured_image
  belongs_to :user
  has_many :comments
  has_many :likes

  def created_time
    self.created_at.strftime("%m/%d/%Y %I:%M%p")
  end
end
