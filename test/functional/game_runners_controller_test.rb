require 'test_helper'

class GameRunnersControllerTest < ActionController::TestCase
  setup do
    @game_runner = game_runners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_runners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_runner" do
    assert_difference('GameRunner.count') do
      post :create, :game_runner => @game_runner.attributes
    end

    assert_redirected_to game_runner_path(assigns(:game_runner))
  end

  test "should show game_runner" do
    get :show, :id => @game_runner.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game_runner.to_param
    assert_response :success
  end

  test "should update game_runner" do
    put :update, :id => @game_runner.to_param, :game_runner => @game_runner.attributes
    assert_redirected_to game_runner_path(assigns(:game_runner))
  end

  test "should destroy game_runner" do
    assert_difference('GameRunner.count', -1) do
      delete :destroy, :id => @game_runner.to_param
    end

    assert_redirected_to game_runners_path
  end
end
