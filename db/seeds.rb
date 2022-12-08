# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Weight.destroy_all
User.destroy_all

user = User.create!(
  email: "andre@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  phone: "111234567",
  first_name: "André",
  last_name: "Gorgen"
)

(1..18).each do |i|
  Weight.create!(
    user: user,
    value: rand(80..95),
    created_at: 18.week.ago + i.week
  )
end

# Weight.create!(
#   user_id: 1,
#   weight: rand(60..100),
#   created_at: Date.today + 32,
#   updated_at: Date.today + 32
# )
