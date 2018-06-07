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

end
