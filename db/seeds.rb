# seeds.rb

# Categories
category = Category.create!(name: 'Vegetables')

# Farmers
farmer = Farmer.create!(
  full_name: 'John Doe',
  email: 'johnie@example.com',
  tel: 123456789,
  location: 'Some Location',
  password: 'password',
  password_confirmation: 'password'
)

# Buyers
buyer1 = Buyer.create!(
  full_name: 'Aliceson',
  email: 'ali@example.com',
  tel: 5551112233,
  location: 'Buyer Location 1',
  password: 'password',
  password_confirmation: 'password'
)

buyer2 = Buyer.create!(
  full_name: 'Bobby Johnson',
  email: 'bob@example.com',
  tel: 5554445566,
  location: 'Buyer Location 2',
  password: 'password',
  password_confirmation: 'password'
)

# Products
product1 = Product.create!(
  name: 'Carrot',
  description: 'Fresh and organic carrot',
  price: 1.99,
  quantity: 100,
  farmer_id: farmer.id,
  category_id: category.id
)

# Orders
Order.create!(
  buyer: buyer1,
  product: product1,
  quantity: 5,
  total_price: 12.5,
  status: 'Pending'
)

Order.create!(
  buyer: buyer2,
  product: product1,
  quantity: 3,
  total_price: 3.0,
  status: 'Shipped'
)

puts 'Seed data has been successfully created.'
