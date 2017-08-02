class User < ApplicationRecord
	before_create :remember
	has_secure_password
	has_many :posts

	validates :name, presence: true, length: { maximum: 40 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: false

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
