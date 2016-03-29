

every 1.day, :at => '7:00 am' do
  rake 'bot:scrape_npr'
end

every 1.day, :at => '9:00 am' do
  rake 'bot:scrape_bbc'
end