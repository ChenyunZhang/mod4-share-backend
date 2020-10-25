class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    # order matters has_many :followeds and has_many :followers, order
    has_many :followeds,
    foreign_key: :followed_id,
    class_name: "Relationship"
   
    has_many :followers, through: :followeds, source: :follower

    has_many :followers,
    foreign_key: :follower_id ,
    class_name: "Relationship"
    
    has_many :followeds, through: :followers, source: :followed

    validates_uniqueness_of :email
    validates_uniqueness_of :username
    # validates_uniqueness_of :follower_id
    # validates_uniqueness_of :followed_id
end

