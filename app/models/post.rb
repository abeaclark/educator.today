class Post < ActiveRecord::Base

  before_save :create_vanity_link

  belongs_to :user

  def timestamp
    created_at.strftime('%d %B %Y %H:%M:%S')
  end

  def create_vanity_link
    self.vanity_link = URI.parse(self.link).host
  end

  def self.scrape_site(url)
    page = MetaInspector.new(url)
    vanity_link = page.host
    link = page.root_url
    title = page.best_title
    description = page.description
    best_image = page.images.best
    all_images = page.images.with_size

    p vanity_link
    p link
    p title
    p description
    p best_image
    p all_images
  end

end
