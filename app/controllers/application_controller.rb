class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user_check
  before_action :current_group_check
  before_action :message_current


  def current_user_check
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_group_check
     @current_group ||= Group.find_by(entry_pass: session[:group_id]) if session[:group_id]
  end

  # MessageBroadcastJobでcurrent_userを判別する
  def message_current
	   Message.current ||= User.find(session[:user_id]) if session[:user_id]
  end

  def brock_not_current_user
  	unless @current_user
  		flash[:notice] = "ログインしてください。"
  		redirect_to("/chatroom/login")
  	end
  end

  def brock_current_user
  	if @current_user
  		@group = Group.find_by(entry_pass: session[:group_id])
  		flash[:notice] = "ログアウトしてください。"
  		redirect_to("/chatroom/#{@group.entry_pass}")
  	end
  end
end
