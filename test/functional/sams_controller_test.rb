require 'test_helper'

class SamsControllerTest < ActionController::TestCase
  setup do
    @sam = sams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sam" do
    assert_difference('Sam.count') do
      post :create, :sam => @sam.attributes
    end

    assert_redirected_to sam_path(assigns(:sam))
  end

  test "should show sam" do
    get :show, :id => @sam.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sam.to_param
    assert_response :success
  end

  test "should update sam" do
    put :update, :id => @sam.to_param, :sam => @sam.attributes
    assert_redirected_to sam_path(assigns(:sam))
  end

  test "should destroy sam" do
    assert_difference('Sam.count', -1) do
      delete :destroy, :id => @sam.to_param
    end

    assert_redirected_to sams_path
  end
end
