require 'test_helper'

class RailsControllerTest < ActionDispatch::IntegrationTest
  test "should get s" do
    get rails_s_url
    assert_response :success
  end

end
