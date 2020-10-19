class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def created_time
    self.created_at.strftime("%m/%d/%Y %I:%M%p")
  end
end
