require 'test_helper'

class PeriodesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:periodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create periode" do
    assert_difference('Periode.count') do
      post :create, :periode => { }
    end

    assert_redirected_to periode_path(assigns(:periode))
  end

  test "should show periode" do
    get :show, :id => periodes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => periodes(:one).to_param
    assert_response :success
  end

  test "should update periode" do
    put :update, :id => periodes(:one).to_param, :periode => { }
    assert_redirected_to periode_path(assigns(:periode))
  end

  test "should destroy periode" do
    assert_difference('Periode.count', -1) do
      delete :destroy, :id => periodes(:one).to_param
    end

    assert_redirected_to periodes_path
  end
end
