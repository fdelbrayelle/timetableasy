require 'test_helper'

class DistancielsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distanciels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distanciel" do
    assert_difference('Distanciel.count') do
      post :create, :distanciel => { }
    end

    assert_redirected_to distanciel_path(assigns(:distanciel))
  end

  test "should show distanciel" do
    get :show, :id => distanciels(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => distanciels(:one).id
    assert_response :success
  end

  test "should update distanciel" do
    put :update, :id => distanciels(:one).id, :distanciel => { }
    assert_redirected_to distanciel_path(assigns(:distanciel))
  end

  test "should destroy distanciel" do
    assert_difference('Distanciel.count', -1) do
      delete :destroy, :id => distanciels(:one).id
    end

    assert_redirected_to distanciels_path
  end
end
