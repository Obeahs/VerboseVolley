# Ensure AdminUser exists in development
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Define a method to determine the category based on the product name
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

# Create categories if they don't exist
categories = [
  'Volleyballs',
  'Knee Pads',
  'Jerseys',
  'Shoes',
  'Accessories'
]

categories.each do |category_name|
  Category.find_or_create_by!(category_name: category_name)
end

puts "Created #{Category.count} categories."

# Create products if they don't exist
products = [
  { product_name: 'Mikasa V200W', category_name: 'Volleyballs', availability: true, price: 150.0, description: 'Volleyball', image_path: 'mikasa_v200w.jpg' },
  { product_name: 'Nike Zoom Hyperace', category_name: 'Shoes', availability: true, price: 120.0, description: 'Volleyball shoes', image_path: 'shoes.jpg' },
  { product_name: 'Knee Pad', category_name: 'Knee Pads', availability: true, price: 25.0, description: 'Knee pad', image_path: 'knee_pad.jpg' },
  { product_name: 'Jersey', category_name: 'Jerseys', availability: true, price: 40.0, description: 'Jersey', image_path: 'jersey.jpg' },
  { product_name: 'VolleyPro Backpack', category_name: 'Accessories', availability: true, price: 55.0, description: 'Good Bag', image_path: 'backpack.jpg' }
]

products.each do |product_data|
  category = Category.find_by(category_name: product_data[:category_name])
  product = Product.find_or_create_by!(
    product_name: product_data[:product_name],
    category: category,
    availability: product_data[:availability],
    price: product_data[:price],
    description: product_data[:description]
  )

  # Attach the image from the 'app/assets/images' folder if it's not already attached
  unless product.image.attached?
    image_path = Rails.root.join('app', 'assets', 'images', product_data[:image_path])
    if File.exist?(image_path)
      product.image.attach(io: File.open(image_path), filename: product_data[:image_path])
    else
      puts "Image file not found: #{image_path}"
    end
  end
end

puts "Created #{Product.count} products."

# Create provinces if they don't exist
provinces = [
  { name: 'Alberta', gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
  { name: 'British Columbia', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.00 },
  { name: 'Manitoba', gst_rate: 0.05, pst_rate: 0.08, hst_rate: 0.00 },
  { name: 'Ontario', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.13 },
  { name: 'Saskatchewan', gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.00 }
]

provinces.each do |province_data|
  Province.find_or_create_by!(name: province_data[:name], gst_rate: province_data[:gst_rate], pst_rate: province_data[:pst_rate], hst_rate: province_data[:hst_rate])
end

puts "Created #{Province.count} provinces."

# Seed from CSV file if needed
require 'csv'
filepath = Rails.root.join('db', 'FIVB scraped.csv')

CSV.foreach(filepath, headers: true) do |row|
  category_name = determine_category(row['Name'])
  category = Category.find_or_create_by!(category_name: category_name)

  Product.find_or_create_by!(
    product_name: row['Name'],
    category: category,
    availability: true,
    price: row['Price'].delete_prefix('$').to_d,
    description: row['Description'],
    on_sale: false,
    new_arrival: true,
    recently_updated: false
  )
end

puts "Seeded products from CSV file."
