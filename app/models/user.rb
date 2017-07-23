class User < ApplicationRecord
	attr_accessor :remember_token
	has_secure_password

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(string)
		Digest::SHA1.hexdigest(string)
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
