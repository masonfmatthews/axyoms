require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Testina", email: "tes@tina.com",
            password: "password", password_confirmation: "password")
  end

  test "login with valid information then logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'mapper/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
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
    assert flash[:error]
    get root_path
    assert !flash[:error]
  end
end