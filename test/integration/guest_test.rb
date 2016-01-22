require 'test_helper'

class GuestTest < ActionDispatch::IntegrationTest
  test 'guest can view public pages' do
    # home page
    get root_path, { controller: :html, action: :home }
    assert_template 'html/home'

    # about page
    # user documentation page
    # developer documentation page
  end

  test 'guest can create account' do
    # click the signup link
    get_via_redirect signup_form_path, { controller: :html, action: :new_user_form }
    assert_template 'html/new_user_form'

    # submit the new account form
    # and redirect to dashboard
    new_user = User.new(first_name: 'New', last_name: 'User', email: 'new@user.com')
    post_via_redirect create_user_path, {
        controller: :users,
        action: :create_user,
        user: {
            first_name: new_user.first_name,
            last_name: new_user.last_name,
            email: new_user.email,
            password: password,
            password_confirmation: password
        }
    }
    assert_template 'html/show_user'
    assert_equal new_user.email, User.last.email
  end

  test 'guest can login' do
    # click on login link
    get_via_redirect login_form_path, { controller: :html, action: :login_form }
    assert_template 'html/login_form'

    # login as participant
    user = login(:participant, show_user_path(users(:participant)))
    assert_template 'html/show_user'
  end
end