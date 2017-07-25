class User < ApplicationRecord
	before_create :remember
	has_secure_password
	has_many :posts

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(string)
		Digest::SHA1.hexdigest(string)
	end

	def remember
		self.remember_digest == nil ? self.remember_digest = User.digest(User.new_token) : update_attribute(:remember_digest, User.digest(User.new_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
