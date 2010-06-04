require 'test_helper'

class EvenementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evenements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evenement" do
    assert_difference('Evenement.count') do
      post :create, :evenement => { }
    end

    assert_redirected_to evenement_path(assigns(:evenement))
  end

  test "should show evenement" do
    get :show, :id => evenements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evenements(:one).to_param
    assert_response :success
  end

  test "should update evenement" do
    put :update, :id => evenements(:one).to_param, :evenement => { }
    assert_redirected_to evenement_path(assigns(:evenement))
  end

  test "should destroy evenement" do
    assert_difference('Evenement.count', -1) do
      delete :destroy, :id => evenements(:one).to_param
    end

    assert_redirected_to evenements_path
  end
end
