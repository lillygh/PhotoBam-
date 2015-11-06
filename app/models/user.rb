class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
	has_secure_password
  	validates :password, presence: true, length: { in: 6..20 }

  	def feed
      following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  		Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  	end

  	def follow(other_user)
  		relationships.create(followed_id: other_user.id)
  	end

  	def unfollow(other_user)
  		relationships.find_by(followed_id: other_user.id).destroy
  	end

  	def following?(other_user)
  		following.include?(other_user)
  	end
end