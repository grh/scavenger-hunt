require 'bcrypt'

module PasswordHelper
  def password_salt
    return "$2a$10$this.is.my.passwd.salt"
  end

  def password_hash
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def password
    return 'password'
  end
end