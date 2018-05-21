class GroupController < ApplicationController
	before_action :brock_not_current_user, {only: [:show, :logout]}
	before_action :brock_current_user, {only: [:new, :create, :login, :login_form]}

	def show
		@group = Group.find_by(entry_pass: params[:pass])
		@messages = Message.where(group_id: @group.id).order(created_at: 'ASC')
		if @current_user.group_id != @group.id
			@current_user_group = Group.find(@current_user.group_id)
			redirect_to "/chatroom/#{@current_user_group.entry_pass}"
		end
	end

	def new
		@group = Group.new
		@user = User.new
	end

	def create
		pass = SecureRandom.urlsafe_base64
		@group = Group.new(name: 'Group', entry_pass: pass, password: params[:password], name_id: params[:name_id])
		if @group.save
		  @user = User.create(name: 'Guest', group_id: @group.id)
		  @group.user_id = @user.id
		  @group.save
		  session[:user_id] = @user.id
		  redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループを作成しました。'
		else
	      render 'group/new'
		end
	end

	def login
		@user = User.new
	end

	def login_form
		@group = Group.find_by(name_id: params[:name_id])
		if @group && @group.authenticate(params[:password])
		  if params[:nickname]
			@user = User.find_by(nickname: params[:nickname])
		  else
			@user = User.create(name: 'Guest', group_id: @group.id)
		  end
		  if @user
		    session[:user_id] = @user.id
		    redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループにログインしました。'
		  else
			flash[:error] = "もう一度実行してください。"
			redirect_to '/chatroom/login'
		  end
		else
			flash[:error] = "パスワードまたはグループIDが違います。"
			redirect_to '/chatroom/login'
		end
	end

	def logout
		@group = Group.find_by(entry_pass: params[:pass])
		if @current_user && @group.id == @current_user.group_id
			session[:user_id] = nil
			@current_user.destroy if @current_user.nickname.blank?
			@group.destroy if @group.user_id == @current_user.id
			redirect_to '/', notice: 'ありがとうございました。'
		else
			@group = Group.find(@current_user.group_id)
			redirect_to "/chatroom/#{@group.entry_pass}", notice: '権限がありません。'
		end
	end

end
