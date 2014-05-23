require 'test_helper'

class TravelsControllerTest < ActionController::TestCase
  setup do
    @travel = travels(:one)
  end

  test "should get index" do
    @user = users(:one)
    sign_in :user, @user
    get :index
    assert_response :success
    assert_not_nil assigns(:travels)
  end

  test "should get new" do
    @user = users(:one)
    sign_in :user, @user
    get :new
    assert_response :success
  end

  test "should create travel" do
    assert_difference('Travel.count') do
      post :create, travel: { name: @travel.name }
    end

    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should show travel" do
    @user = users(:one)
    sign_in :user, @user
    get :show, id: @travel
    assert_response :success
  end

  test "should get edit" do
    @user = users(:one)
    sign_in :user, @user
    get :edit, id: @travel
    assert_response :success
  end

  test "should update travel" do
    @user = users(:one)
    sign_in :user, @user
    patch :update, id: @travel, travel: { name: @travel.name }
    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should destroy travel" do
    assert_difference('Travel.count', -1) do
      delete :destroy, id: @travel
    end

    assert_redirected_to travels_path
  end
end
