require 'test_helper'

class ExamensControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examen" do
    assert_difference('Examen.count') do
      post :create, :examen => { }
    end

    assert_redirected_to examen_path(assigns(:examen))
  end

  test "should show examen" do
    get :show, :id => examens(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examens(:one).id
    assert_response :success
  end

  test "should update examen" do
    put :update, :id => examens(:one).id, :examen => { }
    assert_redirected_to examen_path(assigns(:examen))
  end

  test "should destroy examen" do
    assert_difference('Examen.count', -1) do
      delete :destroy, :id => examens(:one).id
    end

    assert_redirected_to examens_path
  end
end
