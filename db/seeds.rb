# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.destroy_all
# Weight.destroy_all

# user = User.create!(
#   birthday: "14/09/1990",
#   age: 32,
#   gender: "male",
#   height: rand(170..190),
#   email: "a@a.com",
#   password: "123456",
#   password_confirmation: "123456",
#   phone: "1234567",
#   first_name: "Bruno",
#   last_name: "Allevato"
# )

(1..18).each do |i|
  Weight.create!(
    user_id: 7,
    value: rand(80..95),
    # created_at: DateTime.now - i.week
    created_at: 18.week.ago + i.week
    # updated_at: DateTime.now + i
  )
end

# Weight.create!(
#   user_id: 1,
#   weight: rand(60..100),
#   created_at: Date.today + 32,
#   updated_at: Date.today + 32
# )
