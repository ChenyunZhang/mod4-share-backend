class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :image
  has_one :user
end
