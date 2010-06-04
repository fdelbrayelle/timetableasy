require 'test_helper'

class DirigesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diriges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dirige" do
    assert_difference('Dirige.count') do
      post :create, :dirige => { }
    end

    assert_redirected_to dirige_path(assigns(:dirige))
  end

  test "should show dirige" do
    get :show, :id => diriges(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => diriges(:one).id
    assert_response :success
  end

  test "should update dirige" do
    put :update, :id => diriges(:one).id, :dirige => { }
    assert_redirected_to dirige_path(assigns(:dirige))
  end

  test "should destroy dirige" do
    assert_difference('Dirige.count', -1) do
      delete :destroy, :id => diriges(:one).id
    end

    assert_redirected_to diriges_path
  end
end
