# coding: utf-8
class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  has_many :user_post
  has_many :user_auth_token
  
  ROLE = ['user', 'admin', 'unauthenticated_user']

  def user?
    self.role.eql?('user')
  end

  def admin?
    self.role.eql?('admin')
  end

  def other?
    self.role.eql?('unauthenticated_user')
  end

  def create_user(name)
    self.role = 'user'
    ensure_authentication_token
    self.name = name
    self.save!
  end

  def authenticate!(receive_token)
    Devise.secure_compare(self.authentication_token, receive_token)
  end
  
  def ensure_authentication_token
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def reset_authentication_token(receive_token)
    if self.authenticate!(receive_token)
      self.authentication_token = generate_authentication_token
    end
  end

  private
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  
end
