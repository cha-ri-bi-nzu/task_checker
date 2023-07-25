class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: {minimum: 6}

  enum admin: {管理者: true, 一般: false}

  before_update :admin_is_not_change
  before_destroy :admin_is_not_delete

  private
  def admin_is_not_change
    throw(:abort) if User.where(admin: true).count == 1 && self.admin == "一般"
  end

  def admin_is_not_delete
    throw(:abort) if User.where(admin: true).count == 1 && self.admin == "管理者"
  end
  # admin_count = User.group(:admin).count
  #   if admin_count["管理者"] == 1
  #     User(current_user.id).admin = :管理者
  #     redirect_to admin_users_path, notice: "管理者は１人以上いないといけません"
  #   end
end
