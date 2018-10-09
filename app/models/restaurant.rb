# frozen_string_literal: true

# Restaurant class
class Restaurant < ApplicationRecord

  belongs_to :cuisine
  has_many :reviews

  # data validations:
  validates_presence_of :name

  def update_rating
    self.rating = reviews.sum(:rating) / reviews.length
  end

end
