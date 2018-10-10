# Restaurant serializer
class RestaurantSerializer < ApplicationSerializer
  attributes :id, :name, :cuisine_id, :rating, :ten_bis, :address
end
