require 'rake'

desc "This task is called by the Heroku scheduler add-on"

task :scrape_and_update => :environment do
  puts "Scraping from NPR"
  Bot.new(base_url: 'http://www.npr.org/sections/education/', url_regex: /www.npr.org\/sections\/ed\//, username: 'abeclark788').create_posts
  puts "Scraping from BBC"
  Bot.new(base_url: 'http://www.bbc.com/news/education', url_regex: /www.bbc.com\/news\/education/, username: 'abeclark788').create_posts
  puts "done."
end