class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_secure_password
  	validates :password, presence: true, length: { in: 6..20 }

  	def feed
  		Post.where("user_id = ?", id)
  	end
end
