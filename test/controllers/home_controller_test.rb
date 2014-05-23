require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    @user = users(:one)
    sign_in :user, @user
    get :index
    assert_response :success
  end

  test "should get help" do
    @user = users(:one)
    sign_in :user, @user
    get :help
    assert_response :success
  end

  test "should get contact" do
    @user = users(:one)
    sign_in :user, @user
    get :contact
    assert_response :success
  end

end
