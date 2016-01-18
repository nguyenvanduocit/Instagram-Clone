require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:michael)
  end

  test "should get new" do
    get :new
    assert_response :success
  end


  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch :update, id: @user, user: { email: @user.email, user_name: @user.user_name }

    assert_redirected_to user_path(assigns(:user))
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end

end
