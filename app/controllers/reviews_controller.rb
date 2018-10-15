class ReviewsController < ApplicationController

  def index
    restaurant_id = params.require(:restaurant_id)
    render json: Review.where(:restaurant_id => restaurant_id)
  end

  def show
    render json: Review.find(params[:id])
  end

  def create
    render json: Review.create!(review_params), status: :created
  end

  def update
    render json: Review.find(params[:id]).update!(review_params), status: :accepted
  end

  def destroy
    render json: Review.find(params[:id]).destroy!, status: :accepted
  end

  private

  def review_params
    params.require(:review).permit(:rating, :summary, :full_review, :user_id, :restaurant_id)
  end

end