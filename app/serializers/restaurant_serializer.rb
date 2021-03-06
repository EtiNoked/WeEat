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

class RestaurantSerializer < ApplicationSerializer
  attributes :name, :cuisine_name, :rating, :ten_bis, :address
  has_many :reviews

  def cuisine_name
    object.cuisine.name
  end
end
