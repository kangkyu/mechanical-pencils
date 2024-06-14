# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Item.create!([
  { title: "Pentel Sharp Kerry", maker: "Pentel" },
  { title: "Tombow Zoom", maker: "Tombow" },
  { title: "Blick Premier", maker: "Blick" }
])

User.create!(email: "kangkyu@example.com", password: "1234")
Ownership.find_or_create_by(user: User.first, item: Item.first)
