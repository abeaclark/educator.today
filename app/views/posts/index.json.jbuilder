json.array!(@posts) do |post|
  json.extract! post, :id, :title, :link, :user_id, :upvotes, :score
  json.url post_url(post, format: :json)
end
