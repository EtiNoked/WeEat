class Review < ApplicationRecord

  belongs_to :restaurant

  after_save :update_restaurant_rating
  after_destroy :update_restaurant_rating

  private

  def update_restaurant_rating
    restaurant.update_rating
  end
end
