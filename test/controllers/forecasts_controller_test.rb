require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forecasts_index_url
    assert_response :success
  end

  test "should get new" do
    get forecasts_new_url
    assert_response :success
  end
end
