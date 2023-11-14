class Product < ApplicationRecord
  belongs_to :farmer
  belongs_to :category
end
