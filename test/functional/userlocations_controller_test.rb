require 'test_helper'

class UserlocationsControllerTest < ActionController::TestCase
  setup do
    @userlocation = userlocations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userlocations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userlocation" do
    assert_difference('Userlocation.count') do
      post :create, userlocation: { address: @userlocation.address, lat: @userlocation.lat, lng: @userlocation.lng }
    end

    assert_redirected_to userlocation_path(assigns(:userlocation))
  end

  test "should show userlocation" do
    get :show, id: @userlocation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @userlocation
    assert_response :success
  end

  test "should update userlocation" do
    put :update, id: @userlocation, userlocation: { address: @userlocation.address, lat: @userlocation.lat, lng: @userlocation.lng }
    assert_redirected_to userlocation_path(assigns(:userlocation))
  end

  test "should destroy userlocation" do
    assert_difference('Userlocation.count', -1) do
      delete :destroy, id: @userlocation
    end

    assert_redirected_to userlocations_path
  end
end
