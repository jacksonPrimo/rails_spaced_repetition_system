require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get signin" do
    get auth_signin_url
    assert_response :success
  end

  test "should get singup" do
    get auth_singup_url
    assert_response :success
  end
end
