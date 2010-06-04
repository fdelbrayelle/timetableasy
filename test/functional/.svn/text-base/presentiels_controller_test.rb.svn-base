require 'test_helper'

class PresentielsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presentiels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presentiel" do
    assert_difference('Presentiel.count') do
      post :create, :presentiel => { }
    end

    assert_redirected_to presentiel_path(assigns(:presentiel))
  end

  test "should show presentiel" do
    get :show, :id => presentiels(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => presentiels(:one).id
    assert_response :success
  end

  test "should update presentiel" do
    put :update, :id => presentiels(:one).id, :presentiel => { }
    assert_redirected_to presentiel_path(assigns(:presentiel))
  end

  test "should destroy presentiel" do
    assert_difference('Presentiel.count', -1) do
      delete :destroy, :id => presentiels(:one).id
    end

    assert_redirected_to presentiels_path
  end
end
