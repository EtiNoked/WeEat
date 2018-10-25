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

    JSON.parse(response.body)
  end

  def saveCuisines
    uri = URI.parse(ENV['ZOMATO_URL'] + ENV['ZOMATO_CUISINES_EXT'])
    response = getResponse(uri)
    cuisines = response["cuisines"]

    cuisines.each do |cuisine|
      new_cuisine = Cuisine.new do |newCuisine|
        newCuisine.id = cuisine["cuisine"]["cuisine_id"]
        newCuisine.name = cuisine["cuisine"]["cuisine_name"]
      end
      new_cuisine.save!
    end
  end

  def saveReviews(restaurant_id)
    request_utl = ENV['ZOMATO_URL'] + ENV['ZOMATO_REVIEWS_EXT'] + restaurant_id.to_s
    uri = URI.parse(request_utl)
    response = getResponse(uri)
    reviews = response["user_reviews"]
    reviews.each do |review|
      review = review["review"]
      new_review = Review.new do |newReview|
        newReview.id = review["id"]
        newReview.restaurant_id = restaurant_id
        newReview.rating = review["rating"]
        newReview.summary = review["rating_text"]
        newReview.full_review = review["review_text"]
      end
      new_review.save!
    end


  end

  desc "Find NYC Restaurants through Zomato API and save it to DB"
  task getRestaurants: :environment do

    saveCuisines


    uri = URI.parse(ENV['ZOMATO_URL'] + ENV['ZOMATO_RESTAURANTS_EXT'])
    response = getResponse(uri)
    restaurants = response["restaurants"]
    restaurants.each do |restaurant|
      new_rest = Restaurant.new do |newRestaurant|
        restaurant = restaurant["restaurant"]
        newRestaurant.id = restaurant["id"]
        newRestaurant.name = restaurant["name"]
        newRestaurant.address = restaurant["location"]["address"]
        newRestaurant.latitude = restaurant["location"]["latitude"]
        newRestaurant.longitude = restaurant["location"]["longitude"]
        cuisine = restaurant["cuisines"].split(',').first
        newRestaurant.cuisine = Cuisine.where({name: cuisine}).first
        newRestaurant.ten_bis = [true, false].sample
      end
      new_rest.save!
      saveReviews new_rest.id
    end
  end
end
