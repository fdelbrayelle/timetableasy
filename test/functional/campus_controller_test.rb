require 'test_helper'

class CampusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campu" do
    assert_difference('Campu.count') do
      post :create, :campu => { }
    end

    assert_redirected_to campu_path(assigns(:campu))
  end

  test "should show campu" do
    get :show, :id => campus(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => campus(:one).to_param
    assert_response :success
  end

  test "should update campu" do
    put :update, :id => campus(:one).to_param, :campu => { }
    assert_redirected_to campu_path(assigns(:campu))
  end

  test "should destroy campu" do
    assert_difference('Campu.count', -1) do
      delete :destroy, :id => campus(:one).to_param
    end

    assert_redirected_to campus_path
  end
end
