require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    set_up_user
    delete logout_path
  end

  test "forwarding after login" do
    get students_path
    log_in_as(@user)
    assert_redirected_to students_path
  end

  test "login with valid information then logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'mapper/packed_graph'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to login_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with bad information then go to root" do
    get login_path
    post login_path, session: { email: @user.email, password: 'iamhaxorz' }
    assert_template "sessions/new"
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", login_path
    assert !flash.empty?
    get login_path
    assert flash.empty?
  end

  test "pages cannot be accessed if not logged in" do
    get students_path
    assert_redirected_to login_path
    assert flash[:error]

    get edit_student_path(1)
    assert_redirected_to login_path
    assert flash[:error]

    get mapper_packed_graph_path
    assert_redirected_to login_path
    assert flash[:error]
  end
end
