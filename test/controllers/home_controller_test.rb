require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get site_parser:post" do
    get home_site_parser:post_url
    assert_response :success
  end
end
