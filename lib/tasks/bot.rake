require 'rake'

namespace :bot do
  desc "TODO"
  task scrape_npr: :environment do
    Bot.new(base_url: 'http://www.npr.org/sections/education/', url_regex: /www.npr.org\/sections\/ed\//, username: 'abeclark788').create_posts
  end

  task scrape_bbc: :environment do
    Bot.new(base_url: 'http://www.bbc.com/news/education', url_regex: /www.bbc.com\/news\/education/, username: 'abeclark788').create_posts
  end

end
