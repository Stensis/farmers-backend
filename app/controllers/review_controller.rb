# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reviewable
  
    # POST /products/1/reviews
    # POST /farmers/1/reviews
    def create
      @review = @reviewable.reviews.new(review_params)
      @review.user = current_user
  
      if @review.save
        render json: @review, status: :created
      else
        render json: @review.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_reviewable
      if params[:product_id]
        @reviewable = Product.find(params[:product_id])
      elsif params[:farmer_id]
        @reviewable = Farmer.find(params[:farmer_id])
      else
        render json: { error: 'Invalid reviewable resource' }, status: :unprocessable_entity
      end
    end
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  end
  