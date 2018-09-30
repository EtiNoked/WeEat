# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def root
    render inline: '', layout: 'application'
  end
end
