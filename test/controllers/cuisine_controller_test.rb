require 'test_helper'

class CuisineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cuisine_index_url
    assert_response :success
  end

  test "should get show" do
    get cuisine_show_url
    assert_response :success
  end

  test "should get new" do
    get cuisine_new_url
    assert_response :success
  end

  test "should get edit" do
    get cuisine_edit_url
    assert_response :success
  end

  test "should get delete" do
    get cuisine_delete_url
    assert_response :success
  end

end
