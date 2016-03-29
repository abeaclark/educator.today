
class Bot < ApplicationController
  def initialize(args)
    @base_url = args[:base_url]
    @url_regex = args[:url_regex]
    @username = args[:username]
  end

  def create_posts
    links = scrape_relevant_links
    user_id = User.find_or_create_by(username: @username, provider: 'admin', image_url: 'https://media.licdn.com/media/p/8/005/096/07c/10d051c.jpg', uid: '1').id
    links.each do |link|
      attributes = Post.scrape_site(link)
      attributes[:user_id] = user_id
      post = Post.create(attributes)
    end
  end


  def scrape_relevant_links
    landing_page = MetaInspector.new(@base_url)
    links = landing_page.links.all
    links = verify_regex(links)
    links = eliminate_duplicates(links)
    return links
  end

  def eliminate_duplicates(array_of_links)
    array_of_links.reject! do |link|
      Post.find_by(link: link)
    end
    return array_of_links
  end

  def verify_regex(array_of_links)
    array_of_links.reject! do |link|
      !@url_regex.match(link)
    end
    return array_of_links
  end

end