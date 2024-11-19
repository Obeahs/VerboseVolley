# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# categories = [
#   'Volleyballs',
#   'Knee Pads',
#   'Jerseys',
#   'Shoes',
#   'Accessories'
# ]

# categories.each do |category_name|
#   Category.create!(category_name: category_name)
# end

# puts "Created #{Category.count} categories."

# # Create Products
# products = [
#   { product_name: 'Mikasa V200W', category_name: 'Volleyballs', availability: true, price: 150.0, description: 'Volleyball', image_path: 'mikasa_v200w.jpg' },
#   { product_name: 'Nike Zoom Hyperace', category_name: 'Shoes', availability: true, price: 120.0, description: 'Volleyball shoes ', image_path: 'shoes.jpg' },
#   { product_name: 'Knee Pad', category_name: 'Knee Pads', availability: true, price: 25.0, description: 'Knee pad', image_path: 'knee_pad.jpg' },
#   { product_name: 'Jersey', category_name: 'Jerseys', availability: true, price: 40.0, description: 'jersey', image_path: 'jersey.jpg' },
#   { product_name: 'VolleyPro Backpack', category_name: 'Accessories', availability: true, price: 55.0, description: 'Good Bag', image_path: 'backpack.jpg' }
# ]

# products.each do |product_data|
#   category = Category.find_by(category_name: product_data[:category_name])
#   product = Product.create!(
#     product_name: product_data[:product_name],
#     category_id: category.id,
#     availability: product_data[:availability],
#     price: product_data[:price],
#     description: product_data[:description]
#   )
  
#   # Attach the image from the 'app/assets/images' folder
#   image_path = Rails.root.join('app', 'assets', 'images', product_data[:image_path])
#   if File.exist?(image_path)
#     product.image.attach(io: File.open(image_path), filename: product_data[:image_path])
#   else
#     puts "Image file not found: #{image_path}"
#   end
# end

# puts "Created #{Product.count} products."

require 'csv'

def determine_category(name)
  case name.downcase
  when /volleyball/
    'Volleyballs'
  when /knee pad/
    'Knee Pads'
  when /jersey/
    'Jerseys'
  when /shoe/
    'Shoes'
  else
    'Accessories'
  end
end

filepath = Rails.root.join('db', 'FIVB scraped.csv')

CSV.foreach(filepath, headers: true) do |row|
  category_name = determine_category(row['Name'])

  category = Category.find_or_create_by!(category_name: category_name)

  Product.create!(
    product_name: row['Name'],
    category_id: category.id,
    availability: true, 
    price: row['Price'].delete_prefix('$').to_d,
    description: row['Description'],
    on_sale: false, 
    new_arrival: true, 
    recently_updated: false  
  )
end


