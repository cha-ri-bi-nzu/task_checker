class Admin::UsersController < ApplicationController
  before_action :are_you_admin?
  before_action :set_user, only: %i[edit update destroy]
  before_action :this_user, only: %i[update destroy]

  def index
    @users = User.select(:id, :name).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find(params_user)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      redirect_to user_path, notice: "#{this_user}さんのプロフィールを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "#{this_user}さんのアカウントを削除しました"
  end

  private
  def users_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def this_user
    this_user = @user.name
  end

  def are_you_admin?
    redirect_to tasks_path(@user.id) unless current_user.admin?
  end
end
