require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    sign_in :user, @user
  end
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
