class CuisinesController < ApplicationController

  def index
    render json: Cuisine.sorted_by_name_asc
  end

  def show
    render json: Cuisine.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    render json: {status: 'error', code: 404, message: error.message}, :status => :not_found
  end

  def create
    render json: Cuisine.create!(cuisine_params), status: :created
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => 400
  end

  def update
    render json: Cuisine.find(params[:id]).update!(cuisine_params), status: :accepted
  rescue ActiveRecord::RecordInvalid => error
    render json: {status: 'error', code: 400, message: error.message}, :status => 400
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  def destroy
    render json: Cuisine.find(params[:id]).destroy!, status: :accepted
  rescue ActiveRecord::RecordNotFound => error
    render json: {status:'error', code: 404, message: error.message}, :status => :not_found
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
