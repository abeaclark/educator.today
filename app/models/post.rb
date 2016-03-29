class Post < ActiveRecord::Base

  before_save :add_username

  belongs_to :user
  has_many :votes

  def timestamp
    created_at.strftime('%d %B %Y %H:%M:%S')
  end

  def create_vanity_link
    self.vanity_link = URI.parse(self.link).host
  end

  def update_score
    points = self.upvotes
    hours_elapsed = (Time.now - self.created_at) / 3600
    p hours_elapsed
    gravity = 1.8

    score = (points) / (hours_elapsed + 2)**gravity
    self.score = score
  end

  def self.scrape_site(url)
    page = MetaInspector.new(url)
    vanity_link = page.host
    link = page.url
    title = page.best_title
    summary = page.description
    best_image = page.images.best
    all_images = page.images.with_size

    return {vanity_link: vanity_link,
            link: link,
            title: title,
            summary: summary,
            photo_url: best_image}
  end

  private

  def add_username
    self.username = User.find(self.user_id).username
  end

end
