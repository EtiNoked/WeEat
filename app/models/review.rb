# == Schema Information
#
# Table name: reviews
#
#  id            :bigint(8)        not null, primary key
#  restaurant_id :integer
#  rating        :integer
#  summary       :string           not null
#  full_review   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Review < ApplicationRecord

  belongs_to :restaurant

  after_save :update_restaurant_rating!
  after_destroy :update_restaurant_rating!

  private

  def update_restaurant_rating!
    restaurant.update_rating!
  end
end
