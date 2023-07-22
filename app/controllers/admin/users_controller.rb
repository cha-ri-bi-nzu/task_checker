class Admin::UsersController < ApplicationController
  before_action :are_you_admin?
  before_action :set_user, only: %i[edit update destroy]
  before_action :this_user, only: %i[update destroy]

  def index
    @users = User.select(:id, :name).includes(:tasks).page(params[:page]).per(10)
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "#{this_user}さんのアカウントを削除しました"
  end

  private
  def users_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin)
  end

  def are_you_admin?
    redirect_to tasks_path(@user.id) unless current_user.admin?
  end
end
