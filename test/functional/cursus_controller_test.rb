require 'test_helper'

class CursusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cursus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cursu" do
    assert_difference('Cursu.count') do
      post :create, :cursu => { }
    end

    assert_redirected_to cursu_path(assigns(:cursu))
  end

  test "should show cursu" do
    get :show, :id => cursus(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cursus(:one).to_param
    assert_response :success
  end

  test "should update cursu" do
    put :update, :id => cursus(:one).to_param, :cursu => { }
    assert_redirected_to cursu_path(assigns(:cursu))
  end

  test "should destroy cursu" do
    assert_difference('Cursu.count', -1) do
      delete :destroy, :id => cursus(:one).to_param
    end

    assert_redirected_to cursus_path
  end
end
