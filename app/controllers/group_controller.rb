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
		@group = Group.new(name: params[:name], entry_pass: pass, question: params[:question], answer: params[:answer])
		if @group.save
          session[:group_id] = @group.entry_pass
		  # regist画面に遷移する
		  redirect_to "/users/regist/#{@group.entry_pass}", notice: 'グループを作成しました。'
		else
	      render 'group/new'
		end
	end

	def login
		@user = User.new
		@group = Group.find_by(entry_pass: params[:pass])
	end

	def login_form
		@group = Group.find_by(entry_pass: params[:pass])
		if @group && @group.answer == params[:user_answer]
			session[:group_id] = @group.entry_pass
			redirect_to "/users/regist/#{@group.entry_pass}", notice: 'ログインしました！'
		else
			if @group
				flash[:error] = "答えが違います。"
				redirect_to "/chatroom/#{@group.entry_pass}/login"
			else
				redirect_to '/', notice: 'お探しのグループは存在しません。'
			end
		end
	end

	def logout
		@group = Group.find_by(entry_pass: params[:pass])
		if @current_group && @current_group.entry_pass == @group.entry_pass
			session[:group_id] = nil
			redirect_to '/', notice: 'ありがとうございました。'
		else
			redirect_to "/chatroom/#{@current_group.entry_pass}", notice: '権限がありません。'
		end
	end

	private
	def check_group_auth
		if session[:group_id] != params[:pass]
			redirect_to "/chatroom/#{session[:group_id]}", notice: '権限がありません。'
		end
	end

end
