class Farmer < ApplicationRecord
    has_many :reviews, as: :reviewable, dependent: :destroy

    def average_rating
        reviews.average(:rating).to_f.round(2)
    end
end
