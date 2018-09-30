# frozen_string_literal: true

module ApplicationHelper
  def present_errors(object)
    render(:partial => 'common/error_messages', :locals => {:object => object})
  end
end
