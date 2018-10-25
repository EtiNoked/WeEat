require 'net/http'
require 'uri'
require 'json'

namespace :zomato_api do

  def getResponse(uri)
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/json"
    request["User-Key"] = "6ad3f6eff60492ea9d4f01379fdbadd6"

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    return JSON.parse(response.body)
  end

  def saveCuisines
    uri = URI.parse("https://developers.zomato.com/api/v2.1/cuisines?city_id=280")
    response = getResponse(uri)
    cuisines = response["cuisines"]

    cuisines.each do |cuisine|
      new_cuisine = Cuisine.new do |key|
        key.id = cuisine["cuisine"]["cuisine_id"]
        key.name = cuisine["cuisine"]["cuisine_name"]
      end
      new_cuisine.save!
    end
  end

  def saveReviews(restaurant_id)
    request_utl = "https://developers.zomato.com/api/v2.1/reviews?res_id=" + restaurant_id.to_s
    uri = URI.parse(request_utl)
    response = getResponse(uri)
    reviews = response["user_reviews"]
    reviews.each do |review|
      review = review["review"]
      new_review = Review.new do |key|
        key.id = review["id"]
        key.restaurant_id = restaurant_id
        key.rating = review["rating"]
        key.summary = review["rating_text"]
        key.full_review = review["review_text"]
      end
      new_review.save!
    end


  end

  desc "Find NYC Restaurants through Zomato API and save it to DB"
  task getRestaurants: :environment do

    saveCuisines

    uri = URI.parse("https://developers.zomato.com/api/v2.1/search?entity_id=280&entity_type=city")
    response = getResponse(uri)
    restaurants = response["restaurants"]
    restaurants.each do |restaurant|
      new_rest = Restaurant.new do |key|
        restaurant = restaurant["restaurant"]
        key.id = restaurant["id"]
        key.name = restaurant["name"]
        key.address = restaurant["location"]["address"]
        key.latitude = restaurant["location"]["latitude"]
        key.longitude = restaurant["location"]["longitude"]
        cuisine = restaurant["cuisines"].split(',').first
        key.cuisine = Cuisine.where({name: cuisine}).first
        key.ten_bis = [true, false].sample
      end
      new_rest.save!
      saveReviews new_rest.id
    end
  end
end
