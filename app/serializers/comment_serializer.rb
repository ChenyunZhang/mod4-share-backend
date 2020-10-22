class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :post_id, :created_time
  has_one :user
  has_one :post
end
