class UsersController < ApplicationController
	before_action :brock_not_current_group, {only: [:edit, :update]}
	before_action :brock_difference_group, {only: [:regist, :regist_form]}

	def regist
		@user = User.new
		@group = Group.find_by(entry_pass: params[:pass])
	end

	def regist_form
		@group = Group.find_by(entry_pass: session[:group_id])
		if params[:name].blank?
			flash[:error] = "名前を入力してください。"
			redirect_to "/users/regist/#{@group.entry_pass}"
			return
		end

		@user = User.new(name: params[:name], password: 'password') unless @current_user
		if !@user
			@current_user.name = params[:name];
			@current_user.save
			redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループを作成しました。'
		else
			if @user.save
				session[:user_id] = @user.id
				p "SUCCESS!![#{session[:user_id]}]"
				redirect_to "/chatroom/#{@group.entry_pass}", notice: 'グループを作成しました。'
			else
				render 'users/regist'
			end
		end

	end

	def edit
	end

	def update
		@user = User.find(params[:id])
		@group = Group.find_by(entry_pass: params[:group_pass])
		@user.nickname = params[:nickname]
		@user.password = params[:password]
		if params[:nickname].blank? || params[:password].blank?
			flash[:error] = "値を入力してください。"
			redirect_to "/chatroom/#{@group.entry_pass}"
		elsif @user.save
			session[:group_id] = nil
			redirect_to '/', notice: '登録しました。'
		else
			# エラーの方法考える
			render 'group/show'
		end
	end

	def login_form
		@user = User.find_by(nickname: params[:nickname])
		if @user && @user.authenticate(params[:password])
			flash[:notice] = 'ログインしました！'
			login_redirect(params[:pass])
		else
			flash[:error] = 'IDとパスワードが一致しません。'
			login_redirect(params[:pass])
		end
	end

	private
	def group_user_auth
		if session[:group_id] != params[:pass]
			redirect_to '/chatroom/login', notice: '権限がありません'
		end
	end

	def brock_difference_group
		check_group = Group.find_by(entry_pass: params[:pass])
		if check_group && @current_group && check_group.entry_pass != @current_group.entry_pass
			redirect_to "/chatroom/#{@current_group.entry_pass}", notice: '権限がありません。'
		end
	end

	def login_redirect(pass)
		if @group = Group.find_by(entry_pass: pass)
			redirect_to "/chatroom/#{@group.entry_pass}"
		else pass == 'top'
			redirect_to '/'
		end
	end

end
