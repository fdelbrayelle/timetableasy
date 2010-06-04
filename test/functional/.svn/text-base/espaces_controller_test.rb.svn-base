require 'test_helper'

class EspacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:espaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create espace" do
    assert_difference('Espace.count') do
      post :create, :espace => { }
    end

    assert_redirected_to espace_path(assigns(:espace))
  end

  test "should show espace" do
    get :show, :id => espaces(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => espaces(:one).id
    assert_response :success
  end

  test "should update espace" do
    put :update, :id => espaces(:one).id, :espace => { }
    assert_redirected_to espace_path(assigns(:espace))
  end

  test "should destroy espace" do
    assert_difference('Espace.count', -1) do
      delete :destroy, :id => espaces(:one).id
    end

    assert_redirected_to espaces_path
  end
end
