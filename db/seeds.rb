# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

5.times do |num|
  User.create(
    username: Faker::Internet.username,
    email: "user#{num + 1}@u.u",
    password: "password",
    confirmed_at: "2025-02-19 00:00:00"
  )
end

3.times do |num|
  User.create(
    username: Faker::Internet.username,
    email: "admin#{num + 1}@a.a",
    password: "password",
    confirmed_at: "2025-02-19 00:00:00",
    admin: true
  )
end

20.times do
  Article.create(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 20),
    user_id: (User.find_by(email: "user#{rand(1..5)}@u.u")).id,
  )
end

5.times do
  Category.create(name: Faker::Sport.sport)
end
