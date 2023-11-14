json.extract! buyer, :id, :full_name, :email, :tel, :location, :created_at, :updated_at
json.url buyer_url(buyer, format: :json)
