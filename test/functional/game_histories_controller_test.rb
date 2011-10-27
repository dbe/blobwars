require 'test_helper'

class GameHistoriesControllerTest < ActionController::TestCase
  setup do
    @game_history = game_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_history" do
    assert_difference('GameHistory.count') do
      post :create, :game_history => @game_history.attributes
    end

    assert_redirected_to game_history_path(assigns(:game_history))
  end

  test "should show game_history" do
    get :show, :id => @game_history.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game_history.to_param
    assert_response :success
  end

  test "should update game_history" do
    put :update, :id => @game_history.to_param, :game_history => @game_history.attributes
    assert_redirected_to game_history_path(assigns(:game_history))
  end

  test "should destroy game_history" do
    assert_difference('GameHistory.count', -1) do
      delete :destroy, :id => @game_history.to_param
    end

    assert_redirected_to game_histories_path
  end
end
