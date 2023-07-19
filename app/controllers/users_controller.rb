class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :are_you_current_user?, only: %i[show edit update]

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

  # def destroy
  #   lost_name = @user.name
  #   @user.destroy
  #   redirect_to new_user_path, notice: "#{lost_name}さんのアカウントを削除しました"
  # end

  private
  def users_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, task_attributes: %i[id name time_limit status priority created_at destroy])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def are_you_current_user?
    redirect_to tasks_path(@user.id) unless @user.id == current_user.id
  end
end
