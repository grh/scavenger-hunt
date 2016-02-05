require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  test 'admin can create account' do
    # need to write this - admin creating account for other user?
  end
  
  test 'new installation create admin account' do
    # no admin account present 
    # redirect to the signup link
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
end