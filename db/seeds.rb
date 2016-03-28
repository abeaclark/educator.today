require 'faker'

10.times do
  user = User.create({
      provider: ['google', 'facebook'].sample,
      uid: 'randomnumber102938',
      name: Faker::Name.name,
      location: Faker::Address.city,
      image_url: Faker::Avatar.image,
      url: 'Faker::Internet.url',
      username: Faker::Internet.user_name
  })

  4.times do
    Post.create({
      title: Faker::Hipster.sentence(5),
      link: 'http://www.abeclark.com',
      vanity_link: 'abeclark.com',
      photo_url: Faker::Avatar.image,
      summary: Faker::Hipster.paragraph(3),
      user_id: user.id,
      upvotes: rand(45),
      score: 0
    })

  end

end