class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user_check

  def current_user_check
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def brock_not_current_user
  	unless @current_user
  		flash[:notice] = "ログインしてください。"
  		redirect_to("/chatroom/login")
  	end
  end

  def brock_current_user
  	if @current_user
  		@group = Group.find(@current_user.group_id)
  		flash[:notice] = "ログアウトしてください。"
  		redirect_to("/chatroom/#{@group.entry_pass}")
  	end
  end
end
