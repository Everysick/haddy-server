class UserPost < ActiveRecord::Base
  belongs_to :user

  def create_user_post(url, user, picture)
    self.item_url = url
    self.user_id = user.id
    self.picture = picture
    self.save!
  end
end
