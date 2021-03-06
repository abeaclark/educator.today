class User < ActiveRecord::Base

  has_many :posts
  has_many :votes

   def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    if user.provider == 'google'
      user.name = auth_hash['info']['name']
      user.location = auth_hash['info']['location']
      user.image_url = auth_hash['info']['image']
      user.id_token = auth_hash['extra']['id_token']
      user.email = auth_hash['info']['email']
      user.gender = auth_hash['extra']['raw_info']['gender']
    end
    if user.provider == 'facebook'
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      user.id_token = auth_hash['credentials']['token']
      user.email = auth_hash['extra']['raw_info']['email']
    end

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
