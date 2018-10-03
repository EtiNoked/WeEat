class ReviewsController < ApplicationController
  def index
    @restaurant_id = params.require(:restaurant_id)
    @reviews = Review.where(:restaurant_id => @restaurant_id)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @review.restaurant_id = params.require(:restaurant_id)
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "New review was saved"
      redirect_to(restaurant_path(@review.restaurant_id))
    else
      flash.now[:notice] = "Could not create new review"
      render('new')
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:notice] = "Review for restaurant #{ @review.restaurant.name } was updated"
      redirect_to(restaurant_path(params[:restuarant_id]))
    else
      @flash.now[:notice] = "Issue with updating review"
      render('edit')
    end
  end

  def delete
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Delete review."
    redirect_to(restaurant_path(params[:restuarant_id]))
  end

  private

  def review_params
    params.require(:review).permit(:rating, :summary, :full_review, :user_id, :restaurant_id)
  end

end