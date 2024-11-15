# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


category1 = Category.create!(category_name: "Volleyballs")
category2 = Category.create!(category_name: "Shoes")

Product.create!(product_name: "Volleyball", price: 20.00, description: "volleyball", category: category1)
Product.create!(product_name: "Shoes", price: 50.00, description: "Shoes for volleyball", category: category2)