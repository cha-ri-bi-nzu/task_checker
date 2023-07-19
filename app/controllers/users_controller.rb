class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.select(:id, :name).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find(params_user)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(users_params)
      redirect_to user_path, notice: "プロフィール編集完了"
    else
      render :edit
    end
  end

  def destroy
    lost_name = @user.name
    @user.destroy
    redirect_to new_user_path, notice: "#{lost_name}さんのアカウントを削除しました"
  end

  private
  def users_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, task_attributes: %i[id name time_limit status priority created_at destroy])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
