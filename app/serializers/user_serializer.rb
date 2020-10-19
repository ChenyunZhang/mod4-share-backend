class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email

  has_many :followers
  has_many :likes

end
