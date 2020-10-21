class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id
  has_one :user
  has_one :post
end
