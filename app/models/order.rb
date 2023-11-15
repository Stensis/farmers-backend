# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :product

  # enum status: [:pending, :confirmed, :cancelled, :shipped, :delivered]
  enum status: { in_cart: 0, placed: 1, confirmed: 2, cancelled: 3, delivered: 4 }

  # ... other model logic ...

  def confirm_order
    update(status: :confirmed, confirmed_at: Time.current)
    # Add any other logic for order confirmation
  end

  def cancel_order
    update(status: :cancelled, cancelled_at: Time.current)
    # Add any other logic for order cancellation
  end

  def mark_delivered
    update(status: :delivered, delivered_at: Time.current)
    # Add any other logic for marking the order as delivered
  end
end
