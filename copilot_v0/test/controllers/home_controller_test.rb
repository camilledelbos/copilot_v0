require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get landing" do
    get :landing
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
