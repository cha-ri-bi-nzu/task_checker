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
    unless current_user.admin == "管理者"
      redirect_to tasks_path(current_user.id)
      flash[:danger] = "管理者権限がない為、アクセス出来ません！"
    end
  end
end
