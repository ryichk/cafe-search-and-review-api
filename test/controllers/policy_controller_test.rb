require 'test_helper'

class PolicyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get policy_index_url
    assert_response :success
  end

end
