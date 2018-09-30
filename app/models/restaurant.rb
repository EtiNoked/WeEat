# frozen_string_literal: true

# Restaurant class
class Restaurant < ApplicationRecord
  # scoping
  scope :sorted, -> { order('name ASC') }

  # data validations:
  validates_presence_of :name
  validates_presence_of :genre
end
