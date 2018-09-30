# frozen_string_literal: true

class RestaurantController < ApplicationController

  before_action :set_cuisines, :except => [:show, :delete, :destroy]

  def index
    @restaurants = Restaurant.sorted
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new({:name => 'Default'})
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      logger.debug "****** New restaurant was seved to DB. *******"
      flash[:notice] = "New restaurant - #{@restaurant.name} was saved."
      redirect_to(restaurant_index_path)
    else
      flash.now[:notice] = "Error occur while saving new restaurant - #{@restaurant.name} : #{@restaurant.errors.full_messages}"
      render('new')
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      logger.debug "****** Restaurant was updated. *******"
      flash[:notice] = "Restaurant - #{@restaurant.name} was updated."
      redirect_to(restaurant_index_path)
    else
      flash.now[:notice] = "Couldn't update restaurant #{@restaurant.name}"
      render('edit')
    end
  end

  def delete
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    flash[:notice] = "Restaurant - #{@restaurant.name} was deleted."
    @restaurant.destroy
    redirect_to(restaurant_index_path)
  end


  private

  def restaurant_params
    params.require(:restaurant)
        .permit(:name, :cuisine_id, :address, :rating, :delivery_time, :ten_bis)
  end

  def set_cuisines
    @cuisines = Cuisine.sorted
  end
end
