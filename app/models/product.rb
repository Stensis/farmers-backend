class Product < ApplicationRecord
  belongs_to :farmer, class_name: 'User', foreign_key: 'farmer_id'
  belongs_to :category
  has_many :reviews, as: :reviewable, dependent: :destroy
end
