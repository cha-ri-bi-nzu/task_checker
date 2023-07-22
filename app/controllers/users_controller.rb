class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :current_user_or_admin, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in? && current_user.admin?
        redirect_to admin_users_path, notice: "#{@user.name}さんのアカウントを作成しました"
      else
        session[:user_id] = @user.id
        redirect_to user_path(@user.id), notice: "アカウント作成完了"
      end
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.includes(:user).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    binding.pry
    if @user.update(user_params)
      if current_user.admin?
        redirect_to admin_users_path, notice: "#{@user.name}さんのプロフィールを編集しました"
      else
        redirect_to user_path, notice: "プロフィール編集完了"
      end
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
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user_or_admin
    redirect_to tasks_path(@user.id) unless @user == current_user || current_user.admin?
  end
end
