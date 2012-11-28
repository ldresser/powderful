require 'test_helper'

class ResortsControllerTest < ActionController::TestCase
  setup do
    @resort = resorts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resorts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resort" do
    assert_difference('Resort.count') do
      post :create, resort: { address: @resort.address, area: @resort.area, city: @resort.city, elevation_base: @resort.elevation_base, elevation_peak: @resort.elevation_peak, lifts: @resort.lifts, longest_trail: @resort.longest_trail, name: @resort.name, pr_advanced: @resort.pr_advanced, pr_beginner: @resort.pr_beginner, pr_expert: @resort.pr_expert, pr_intermediate: @resort.pr_intermediate, runs: @resort.runs, state: @resort.state, trail_map: @resort.trail_map, url: @resort.url, vertical_drop: @resort.vertical_drop, zip: @resort.zip }
    end

    assert_redirected_to resort_path(assigns(:resort))
  end

  test "should show resort" do
    get :show, id: @resort
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resort
    assert_response :success
  end

  test "should update resort" do
    put :update, id: @resort, resort: { address: @resort.address, area: @resort.area, city: @resort.city, elevation_base: @resort.elevation_base, elevation_peak: @resort.elevation_peak, lifts: @resort.lifts, longest_trail: @resort.longest_trail, name: @resort.name, pr_advanced: @resort.pr_advanced, pr_beginner: @resort.pr_beginner, pr_expert: @resort.pr_expert, pr_intermediate: @resort.pr_intermediate, runs: @resort.runs, state: @resort.state, trail_map: @resort.trail_map, url: @resort.url, vertical_drop: @resort.vertical_drop, zip: @resort.zip }
    assert_redirected_to resort_path(assigns(:resort))
  end

  test "should destroy resort" do
    assert_difference('Resort.count', -1) do
      delete :destroy, id: @resort
    end

    assert_redirected_to resorts_path
  end
end
