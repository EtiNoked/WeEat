class CuisinesController < ApplicationController

  before_action :find_related_restaurants, :only => [:delete, :destroy]
  before_action :find_cuisine, :except => [:index, :new, :create]


  def index
    @cuisines = Cuisine.sorted_by_name_asc
  end

  def show; end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.create!(cuisine_params)
    if @cuisine
      flash[:notice] = "New cuisine was saved"
      redirect_to(new_restaurant_path)
    else
      flash.now[:notice] = "Could not create new cuisine"
      render('new')
    end
  end

  def edit; end

  def update
    if @cuisine.update(cuisine_params)
      flash[:notice] = "Cuisine #{ @cuisine.name } was updated"
      redirect_to(cuisines_path)
    else
      @flash.now[:notice] = "Issue with updating cuisine"
      render('edit')
    end
  end

  def delete; end

  def destroy
    if @restaurants.any?
      flash.now[:notice] = "Couldn't delete a cuisine with restaurants associate to it"
      render('delete')
    else
      @cuisine.destroy
      flash[:notice] = "Cuisine #{ @cuisine.name } was deleted"
      redirect_to(cuisines_path)
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def find_related_restaurants
    @restaurants = Restaurant.where("cuisine_id = #{ params.require(:id) }")
  end

  def find_cuisine
    @cuisine = Cuisine.find(params.require(:id))
  end
end
