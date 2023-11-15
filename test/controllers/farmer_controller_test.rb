require "test_helper"

class FarmerControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get farmer_dashboard_url
    assert_response :success
  end
end
