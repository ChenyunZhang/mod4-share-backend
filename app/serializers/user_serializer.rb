class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email, :avatar

  has_many :followers
  has_many :posts
  has_many :likes

end
