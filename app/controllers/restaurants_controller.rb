class RestaurantsController < ApplicationController

  def index
    render json: Restaurant.sorted_by_name_asc
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant

  rescue ActiveRecord::RecordNotFound => error
    render json: {status: 'error', code: 404, message: error.message}, :status => :not_found
  end

  def create
    render json: Restaurant.create!(restaurant_params), status: :created
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => 400
  end

  def update
    render json: Restaurant.find(params[:id]).update!(restaurant_params), status: :accepted
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => 400
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  def destroy
    render json: Restaurant.find(params[:id]).destroy!, status: :accepted
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  private

  def restaurant_params
    params.require(:restaurant)
        .permit(:name, :cuisine_id, :address, :delivery_time, :ten_bis)
  end
end