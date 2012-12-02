require 'test_helper'

class DroutesControllerTest < ActionController::TestCase
  setup do
    @droute = droutes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:droutes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create droute" do
    assert_difference('Droute.count') do
      post :create, droute: { id: @droute.id, latitude: @droute.latitude, longitude: @droute.longitude, origin: @droute.origin, resort_id: @droute.resort_id }
    end

    assert_redirected_to droute_path(assigns(:droute))
  end

  test "should show droute" do
    get :show, id: @droute
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @droute
    assert_response :success
  end

  test "should update droute" do
    put :update, id: @droute, droute: { id: @droute.id, latitude: @droute.latitude, longitude: @droute.longitude, origin: @droute.origin, resort_id: @droute.resort_id }
    assert_redirected_to droute_path(assigns(:droute))
  end

  test "should destroy droute" do
    assert_difference('Droute.count', -1) do
      delete :destroy, id: @droute
    end

    assert_redirected_to droutes_path
  end
end
