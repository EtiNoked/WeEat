class CuisineController < ApplicationController

  before_action :find_related_restaurants, :only => [:delete, :destroy]

  def index
    @cuisines = Cuisine.sorted
  end

  def show
    @cuisine = Cuisine.find(params.require(:id))
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      flash[:notice] = "New cuisine was saved"
      redirect_to(new_restaurant_path)
    else
      flash.now[:notice] = "Could not create new cuisine"
      render('new')
    end
  end

  def edit
    @cuisine = Cuisine.find(params.require(:id))
  end

  def update
    @cuisine = Cuisine.find(params.require(:id))
    if @cuisine.update_attributes(cuisine_params)
      flash[:notice] = "Cuisine #{ @cuisine.name } was updated"
      redirect_to(cuisine_index_path)
    else
      @flash.now[:notice] = "Issue with updating cuisine"
      render('edit')
    end
  end

  def delete
    @cuisine = Cuisine.find(params.require(:id))
  end

  def destroy
    @cuisine = Cuisine.find(params.require(:id))

    if @restaurants.size > 0
      flash.now[:notice] = "Couldn't delete a cuisine with restaurants associate to it"
      render('delete')
    else
      @cuisine.destroy
      flash[:notice] = "Cuisine #{ @cuisine.name } was deleted"
      redirect_to(cuisine_index_path)
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def find_related_restaurants
    @restaurants = Restaurant.where("cuisine_id = #{ params.require(:id) }")
  end
end
