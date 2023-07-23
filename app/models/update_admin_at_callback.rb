class UpdateAdminAtCallback
  def admin_is_not_0(current_user)
  admin_count = User.group(:admin).count
    if admin_count("管理者") == 1 && current_user.admin == "一般"
      current_user = "管理者"
      render :edit, notice: "管理者は１人以上いないといけません"
    end
  end
end