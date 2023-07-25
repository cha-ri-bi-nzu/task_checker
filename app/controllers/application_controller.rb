class ApplicationController < ActionController::Base
  include EnumHelper
  include SessionsHelper

  before_action :login_required

  private
  def login_required
    redirect_to new_session_path, notice: "ログインをして下さい" unless current_user
  end
end
