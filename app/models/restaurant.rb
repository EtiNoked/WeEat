# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  cuisine_id    :integer
#  rating        :integer
#  ten_bis       :boolean          default(FALSE)
#  address       :string
#  delivery_time :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Restaurant < ApplicationRecord

  belongs_to :cuisine
  has_many :reviews

  # data validations:
  validates_presence_of :name

  def update_rating
    self.rating = reviews.empty? ? 0 : (reviews.sum(:rating) / reviews.length)
  end

end
