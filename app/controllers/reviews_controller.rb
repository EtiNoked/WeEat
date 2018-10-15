class ReviewsController < ApplicationController

  def index
    restaurant_id = params.require(:restaurant_id)
    render json: Review.where(:restaurant_id => restaurant_id)
  end

  def show
    render json: Review.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    render json: {status: 'error', code: 404, message: error.message}, :status => :not_found
  end

  def create
    render json: Review.create!(review_params), status: :created
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => :bad_request
  end

  def update
    render json: Review.find(params[:id]).update!(review_params), status: :accepted
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => :bad_request
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  def destroy
    render json: Review.find(params[:id]).destroy!, status: :accepted
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  private

  def review_params
    params.require(:review).permit(:rating, :summary, :full_review, :user_id, :restaurant_id)
  end

end