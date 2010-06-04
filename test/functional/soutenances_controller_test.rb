require 'test_helper'

class SoutenancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:soutenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create soutenance" do
    assert_difference('Soutenance.count') do
      post :create, :soutenance => { }
    end

    assert_redirected_to soutenance_path(assigns(:soutenance))
  end

  test "should show soutenance" do
    get :show, :id => soutenances(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => soutenances(:one).id
    assert_response :success
  end

  test "should update soutenance" do
    put :update, :id => soutenances(:one).id, :soutenance => { }
    assert_redirected_to soutenance_path(assigns(:soutenance))
  end

  test "should destroy soutenance" do
    assert_difference('Soutenance.count', -1) do
      delete :destroy, :id => soutenances(:one).id
    end

    assert_redirected_to soutenances_path
  end
end
