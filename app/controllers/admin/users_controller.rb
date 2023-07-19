class Admin::UsersController < ApplicationController
  def index
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
  end

  def destroy
  end

  private
  def users_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :task_attributes: %i[id name time_limit status priority created_at destroy])
  end
end
