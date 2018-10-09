class RestaurantsController < ApplicationController

  before_action :set_cuisines, :except => [:show, :delete, :destroy]
  before_action :find_restaurant, :except => [:index, :new, :create]

  def index
    @restaurants = Restaurant.sorted_by_name_asc
  end

  def show; end

  def new
    @restaurant = Restaurant.new({:name => 'Default'})
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    if @restaurant
      flash[:notice] = "New restaurant - #{@restaurant.name} was saved."
      redirect_to(restaurants_path)
    else
      flash.now[:notice] = "Error occur while saving new restaurant - #{@restaurant.name} : #{@restaurant.errors.full_messages}"
      render('new')
    end
  end

  def edit; end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant - #{@restaurant.name} was updated."
      redirect_to(restaurants_path)
    else
      flash.now[:notice] = "Couldn't update restaurant #{@restaurant.name}"
      render('edit')
    end
  end

  def delete; end

  def destroy
    flash[:notice] = "Restaurant - #{@restaurant.name} was deleted."
    @restaurant.destroy
    redirect_to(restaurants_path)
  end


  private

  def restaurant_params
    params.require(:restaurant)
        .permit(:name, :cuisine_id, :address, :rating, :delivery_time, :ten_bis)
  end

  def set_cuisines
    @cuisines = Cuisine.sorted_by_name_asc
  end

  def find_restaurant
    @restaurant = Restaurant.find(params.require(:id))
  end

end