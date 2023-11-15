require "test_helper"

class BuyerControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get buyer_dashboard_url
    assert_response :success
  end
end
