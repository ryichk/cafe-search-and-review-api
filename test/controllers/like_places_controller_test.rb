require 'test_helper'

class LikePlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get like_places_create_url
    assert_response :success
  end

  test "should get destroy" do
    get like_places_destroy_url
    assert_response :success
  end

end
