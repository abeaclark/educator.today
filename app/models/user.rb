class User < ActiveRecord::Base

   def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls']['Twitter']
    user.assign_username
    user.save!
    user
  end


  def assign_username(username=nil)
    username = username || concatenate_username(self.name)
    return self.username = username unless User.find_by username: username
    assign_username(username + rand(1000).to_s)
  end

  def concatenate_username(username)
    return username.downcase.sub /\W/, ''
  end

end
