class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  		log_in @user
  		flash[:success] = "Logged in successfully."
  		redirect_to root_url
  	else
  		flash[:warning] = "Invalid email adress or password."
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
