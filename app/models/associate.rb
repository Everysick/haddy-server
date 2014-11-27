class Associate < ActiveRecord::Base
  belongs_to :user

  def create_associate(token, user)
    self.token = token
    self.user_id = user.id
    self.save!
  end

end
