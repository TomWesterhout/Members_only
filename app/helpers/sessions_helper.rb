module SessionsHelper

	def log_in(user)
		user.remember
		cookies.permanent[:remember] = user.remember_digest
		@current_user = user
	end

	def logged_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(remember_digest: cookies[:remember])
	end

	def log_out
		@current_user = nil
		cookies.delete(:remember)
	end
end
