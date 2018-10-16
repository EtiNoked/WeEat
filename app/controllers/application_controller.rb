# frozen_string_literal: true

class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token

  def root
    render inline: '', layout: 'application'
  end
end
