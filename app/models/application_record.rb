# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # scoping
  scope :sorted_by_name_asc, -> { order('name ASC') }

end
