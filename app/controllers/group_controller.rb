class GroupController < ApplicationController
	before_action :brock_not_current_user, {only: [:show]}
	before_action :brock_current_user, {only: [:new, :create]}

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
		@group = Group.new(name: params[:name], entry_pass: pass, password: params[:password])
		if @group.save
			@user = User.new(name: params[:username], group_id: @group.id)
			if @user.save
			  @group.user_id = @user.id
			  @group.save
			  session[:user_id] = @user.id
			  redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループを作成しました。'
			else
				render 'group/new'
			end
		else
			render 'group/new'
		end
	end

	def login
	end

	def login_form
		@group = Group.find_by(entry_pass: params[:pass])
		if @group && @group.authenticate(params[:password])
			@user = User.new(name: params[:username], group_id: @group.id)
			if @user.save
			  session[:user_id] = @user.id
			  redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループを作成しました。'
			else
			  render 'group/login'
			end
		else
			redirect_to '/chatroom/login', notice: "IDまたはパスワードが違います。"
		end
	end

	def logout
		@group = Group.find_by(entry_pass: params[:pass])
		if @current_user
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
