class CuisinesController < ApplicationController

  def index
    render json: Cuisine.sorted_by_name_asc
  end

  def show
    render json: Cuisine.find(params[:id])
  end

  def create
    render json: Cuisine.create!(cuisine_params), status: :created
  end

  def update
    render json: Cuisine.find(params[:id]).update!(cuisine_params), status: :accepted
  end

  def destroy
    render json: Cuisine.find(params[:id]).destroy!, status: :accepted
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
