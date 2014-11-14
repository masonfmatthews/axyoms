require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @me = User.new(name: "Me", email: "me@me.com",
        password: "iamapassword", password_confirmation: "iamapassword")
    @bad = User.new(email: "bad@bad")
  end

  def test_user_validations
    assert @me.valid?
    assert !@bad.valid?
    assert_equal @bad.errors.full_messages,
        ["Name can't be blank", "Email is invalid", "Password can't be blank"]
  end
end
