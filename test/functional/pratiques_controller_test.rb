require 'test_helper'

class PratiquesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pratiques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pratique" do
    assert_difference('Pratique.count') do
      post :create, :pratique => { }
    end

    assert_redirected_to pratique_path(assigns(:pratique))
  end

  test "should show pratique" do
    get :show, :id => pratiques(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pratiques(:one).id
    assert_response :success
  end

  test "should update pratique" do
    put :update, :id => pratiques(:one).id, :pratique => { }
    assert_redirected_to pratique_path(assigns(:pratique))
  end

  test "should destroy pratique" do
    assert_difference('Pratique.count', -1) do
      delete :destroy, :id => pratiques(:one).id
    end

    assert_redirected_to pratiques_path
  end
end
