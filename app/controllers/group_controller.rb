class GroupController < ApplicationController
	before_action :brock_current_group, {only: [:new, :create, :login, :login_form]}
	before_action :brock_not_current_group, {only: [:show, :logout]}
	before_action :check_group_auth, {only: [:show, :logout]}

	def show
		@group = Group.find_by(entry_pass: params[:pass])
		@messages = Message.where(group_id: @group.id).order(created_at: 'ASC')
		@user = User.new
		if @current_group.entry_pass != params[:pass]
			redirect_to "/chatroom/#{@current_group.entry_pass}", notice: '権限がありません。'
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
          session[:group_id] = @group.entry_pass
		  session[:user_id] = @user.id
		  # regist画面に遷移する
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
			session[:group_id] = @group.entry_pass
			redirect_to "/users/regist/#{@group.entry_pass}", notice: '名前を入力してください。'
		else
			flash[:error] = "パスワードまたはグループIDが違います。"
			redirect_to '/chatroom/login'
		end
	end

	def logout
		@group = Group.find_by(entry_pass: params[:pass])
		if @current_group && @current_group.entry_pass == @group.entry_pass
			session[:group_id] = nil
			if @current_user.nickname.blank?
				@current_user.destroy
				session[:user_id] = nil
			end
			@group.destroy if @group.user_id == @current_user.id
			redirect_to '/', notice: 'ありがとうございました。'
		else
			@group = Group.find(@current_user.group_id)
			redirect_to "/chatroom/#{@group.entry_pass}", notice: '権限がありません。'
		end
	end

	private
	def check_group_auth
		if session[:group_id] != params[:pass]
			session[:user_id] = nil
			redirect_to '/', notice: '権限がありません。'
		end
	end

end
