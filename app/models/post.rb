class Post < ActiveRecord::Base

  before_save :create_vanity_link

  belongs_to :user

  def timestamp
    created_at.strftime('%d %B %Y %H:%M:%S')
  end

  def create_vanity_link
    self.vanity_link = URI.parse(self.link).host
  end

end
