class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email, :avatar, :location, :gender, :posts

  has_many :followers
  has_many :followeds
  has_many :posts
  has_many :likes

end
