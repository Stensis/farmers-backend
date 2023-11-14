# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Categories
categories = Category.create([
  { name: 'Vegetables' },
  { name: 'Fruits' },
  # Add more categories as needed
])

# Farmers
farmers = Farmer.create([
  { full_name: 'John Doe', email: 'john@example.com', tel: 1234567890, location: 'Farm Location 1' },
  { full_name: 'Jane Doe', email: 'jane@example.com', tel: 9876543210, location: 'Farm Location 2' },
  # Add more farmers as needed
])

# Buyers
buyers = Buyer.create([
  { full_name: 'Alice Smith', email: 'alice@example.com', tel: 5551112233, location: 'Buyer Location 1' },
  { full_name: 'Bob Johnson', email: 'bob@example.com', tel: 5554445566, location: 'Buyer Location 2' },
  # Add more buyers as needed
])

# Products
products = Product.create([
  { name: 'Tomato', description: 'Fresh red tomatoes', price: 2.5, quantity: 100, farmer: farmers.first, category: categories.first },
  { name: 'Apple', description: 'Crisp and juicy apples', price: 1.0, quantity: 50, farmer: farmers.second, category: categories.second },
  # Add more products as needed
])

# Orders
orders = Order.create([
  { buyer: buyers.first, product: products.first, quantity: 5, total_price: 12.5, status: 'Pending' },
  { buyer: buyers.second, product: products.second, quantity: 3, total_price: 3.0, status: 'Shipped' },
  # Add more orders as needed
])

puts 'Seed data has been successfully created.'
