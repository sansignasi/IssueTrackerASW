class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  #def authenticate
  	#redirect_to :login unless user_signed_in?
  #end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate
  	token2 = request.headers['token']
  	if(token2)
  	  @user = User.where(token: token2).first
  	else
  	  @user = current_user
  	end
  end
  
  def user_signed_in?
  	# converts current_user to a boolean by negating the negation
  	!!current_user
  end

end