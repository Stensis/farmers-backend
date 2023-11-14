json.extract! order, :id, :buyer_id, :product_id, :quantity, :total_price, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
