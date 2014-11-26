class UserAuthToken < ActiveRecord::Base
  belongs_to :user

  SERVICE_ROLE = ['twitter']

  def create_twitter(token, token_secret, user)
    self.token = token
    self.token_secret = token_secret
    self.service = 'twitter'
    self.user_id = user.id
    self.save!
  end
end
