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
    assert @bad.errors.full_messages.include? "Email is invalid"
    assert @bad.errors.full_messages.include? "Password can't be blank"
    assert @bad.errors.full_messages.include? "Name can't be blank"
  end
end
