5.times do
   User.create!(
   email:    Faker::Internet.email,
   password: 'password'
   )
 end
 users = User.all



10.times do
  page = Page.create!(
  user_id: users.sample.id,
  title: Faker::Book.title,
  body: Faker::Hipster.paragraph,
  private: false
  )

end
pages = Page.all


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Page.count} pages created"
