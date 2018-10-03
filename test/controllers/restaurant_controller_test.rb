# frozen_string_literal: true

require 'test_helper'

class RestaurantControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get restaurant_index_url
    assert_response :success
  end

  test 'should get show' do
    get restaurant_show_url
    assert_response :success
  end

  test 'should get new' do
    get restaurant_new_url
    assert_response :success
  end

  test 'should get edit' do
    get restaurant_edit_url
    assert_response :success
  end

  test 'should get delete' do
    get restaurant_delete_url
    assert_response :success
  end
end
