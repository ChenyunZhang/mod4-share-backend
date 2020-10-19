class Post < ApplicationRecord

  has_one_attached :featured_image, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def created_time
    self.created_at.strftime("%m/%d/%Y %I:%M%p")
  end
end
