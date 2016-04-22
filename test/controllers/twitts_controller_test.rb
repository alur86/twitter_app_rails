require 'test_helper'

class TwittsControllerTest < ActionController::TestCase
  setup do
    @twitt = twitts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitt" do
    assert_difference('Twitt.count') do
      post :create, twitt: { : @twitt., message: @twitt.message }
    end

    assert_redirected_to twitt_path(assigns(:twitt))
  end

  test "should show twitt" do
    get :show, id: @twitt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitt
    assert_response :success
  end

  test "should update twitt" do
    patch :update, id: @twitt, twitt: { : @twitt., message: @twitt.message }
    assert_redirected_to twitt_path(assigns(:twitt))
  end

  test "should destroy twitt" do
    assert_difference('Twitt.count', -1) do
      delete :destroy, id: @twitt
    end

    assert_redirected_to twitts_path
  end
end
