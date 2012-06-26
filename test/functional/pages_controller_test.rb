require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
