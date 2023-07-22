class Admin::UsersController < ApplicationController
  before_action :user_or_admin

  def index
    @users = User.select(:id, :name, :admin).includes(:tasks).page(params[:page]).per(10)
  end
  
  def destroy
    @user = User.find(params[:id])
    lost_user = @user.name
    @user.destroy
    redirect_to admin_users_path, notice: "#{lost_user}さんのアカウントを削除しました"
  end

  private
  def user_or_admin
    redirect_to tasks_path(@user.id) unless current_user.admin = "管理者"
  end
end
