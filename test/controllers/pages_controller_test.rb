require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get developer" do
    get pages_developer_url
    assert_response :success
  end

end
