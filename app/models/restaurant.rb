# frozen_string_literal: true

# Restaurant class
class Restaurant < ApplicationRecord

  belongs_to :cuisine

  # data validations:
  validates_presence_of :name
end
