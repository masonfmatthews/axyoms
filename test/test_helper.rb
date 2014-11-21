ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'concept_fixtures'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include ConceptFixtures
  run_concept_fixtures
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end

  def set_up_student
    @student = students(:one)
  end

  def set_up_user
    @user = User.create!(name: "User", email: "user@example.com",
            password: "password", password_confirmation: "password")
    log_in_as(@user)
  end

  def log_in_as(user, options = {})
    if integration_test?
      post login_url, session: { email: user.email, password: "password" }
    else
      session[:user_id] = user.id
    end
  end

  private def integration_test?
    defined?(post_via_redirect)
  end
end
