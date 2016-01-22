ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'helpers/password_helper'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include PasswordHelper

  private

  # login: simulates a user logging
  # parameters: fixture symbol for user to be logged in
  # return value: the user that was logged in
  def login(u, r = nil)
    # input email and password
    # and submit the form
    user = users(u)
    post_via_redirect create_session_path, {
        controller: :sessions,
        action: :create,
        user: {
            email: user.email,
            password: password
        },
        redirect_to: r
    }
    return user
  end
end
