class User < ActiveRecord::Base
	has_secure_password
  	validates :password, presence: true, length: { in: 6..20 }

  	def forget
  		update_attribute(:remember_digest, nil)
  	end
end
