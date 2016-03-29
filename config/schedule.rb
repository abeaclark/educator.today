

every 1.minute, :environment => "development" do
  rake 'bot:scrape_npr'
end

every 1.day, :environment => "development", :at => '3:27 pm' do
  rake 'bot:scrape_bbc'
end