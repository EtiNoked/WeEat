class ReviewSerializer < ApplicationSerializer
  attributes :restaurant_id, :rating, :summary, :full_review
end
