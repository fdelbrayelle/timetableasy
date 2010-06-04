require 'test_helper'

class CoursControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cours" do
    assert_difference('Cours.count') do
      post :create, :cours => { }
    end

    assert_redirected_to cours_path(assigns(:cours))
  end

  test "should show cours" do
    get :show, :id => cours(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cours(:one).id
    assert_response :success
  end

  test "should update cours" do
    put :update, :id => cours(:one).id, :cours => { }
    assert_redirected_to cours_path(assigns(:cours))
  end

  test "should destroy cours" do
    assert_difference('Cours.count', -1) do
      delete :destroy, :id => cours(:one).id
    end

    assert_redirected_to cours_path
  end
end
