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
     if !@current_group && session[:group_id]
      session[:group_id] = nil
      redirect_to '/', notice: 'グループが存在しません。'
    end
  end

  def brock_current_group
    if @current_group
      redirect_to "/chatroom/#{@group.entry_pass}", notice: "グループに参加中です。"
    end
  end

  def brock_not_current_group
    unless @current_group
      flash[:notice] = "ログインしてください。"
      redirect_to("/chatroom/login")
    end
  end

  # MessageBroadcastJobでcurrent_userを判別する
  def message_current
	   Message.current ||= User.find(session[:user_id]) if session[:user_id]
  end


end
