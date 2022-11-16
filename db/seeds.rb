# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

(1..30).each do |i|
  Weight.create!(
    user_id: 3,
    weight: rand(60..100),
    created_at: DateTime.now + i,
    updated_at: DateTime.now + i
  )
end

# Weight.create!(
#   user_id: 1,
#   weight: rand(60..100),
#   created_at: Date.today + 32,
#   updated_at: Date.today + 32
# )
