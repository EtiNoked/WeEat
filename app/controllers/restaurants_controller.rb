class RestaurantsController < ApplicationController

  def index
    render json: Restaurant.sorted_by_name_asc
  end

  def show
    render json: Restaurant.find(params[:id])
  end

  def create
    render json: Restaurant.create!(restaurant_params), status: :created
  end

  def update
    render json: Restaurant.find(params[:id]).update!(restaurant_params), status: :accepted
  end

  def destroy
    render json: Restaurant.find(params[:id]).destroy!, status: :accepted
  end

  private

  def restaurant_params
    params.require(:restaurant)
        .permit(:name, :cuisine_id, :address, :delivery_time, :ten_bis)
  end
end