class User < ActiveRecord::Base
  before_save :get_encrypted_password
  validates :email, uniqueness: true

  private

  def self.authenticate(login_email, login_password)
    @user = self.find_by_email(login_email)
    return @user if BCrypt::Password.new(@user.password) == login_password && @user.email == login_email
  end

  def get_encrypted_password
    self.password = BCrypt::Password.create(self.password)
  end

end
