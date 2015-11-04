class SessionsController < ApplicationController
 
 def new
 end

 def create
  #logs in the user and takes them to the user's show page
  # email addresses are saved as lowercase so use .downcase to ensure a match
  user = User.find_by(email: params[:session][:email].downcase)
  #determines if the user is valid
  if user && user.authenticate(params[:session][:password])	
  	log_in user
  	#for the 'remember me' checkbox on login page:
  	params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  	redirect_to user	
  else
  	#error message
  	flash.now[:danger] = 'Invalid email/password'
  	render 'new'
  end
 end

 def destroy
	session.delete(:user_id)
	redirect_to login_path
 end

end
