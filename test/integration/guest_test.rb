require 'test_helper'

class GuestTest < ActionDispatch::IntegrationTest
  test 'guest can view public pages' do
    # home page
    get root_path, { controller: :html, action: :home }
    assert_template 'html/home'

    # about page
    get about_path, { controller: :html, action: :about_doc }
    assert_template 'html/about_doc'

    # user documentation page
    get user_doc_path, { controller: :html, action: :user_doc }
    assert_template 'html/user_doc'

    # developer documentation page
    get developer_doc_path, { controller: :html, action: :developer_doc }
    assert_template 'html/developer_doc'
  end

  test 'guest cannot view unauthorized pages' do
    # show event
    event = events(:event1)
    get_via_redirect show_event_path(event), { controller: :html, action: :show_event }
    assert_template 'html/login_form'

    # show user
    user = users(:participant)
    get_via_redirect show_user_path(user), { controller: :html, action: :show_user }
    assert_template 'html/home'

    # create event
    get_via_redirect new_event_form_path, { controller: :html, action: :new_event_form_path }
    assert_template 'html/home'

    # create location
    get_via_redirect new_location_form_path, { controller: :html, action: :new_location_form_path }
    assert_template 'html/home'
    
    # join event
    event = events(:event1)
    get_via_redirect join_event_path(event), { controller: :user, action: :join_event_path }
    assert_template 'html/login_form'

    # show all events
    get_via_redirect show_all_events_path, { controller: :html, action: :show_all_events_path }
    assert_template 'html/home'
    
    # show all locations
    get_via_redirect show_all_locations_path, { controller: :html, action: :show_all_locations_path }
    assert_template 'html/home'
    
    # show all users
    get_via_redirect show_all_users_path, { controller: :html, action: :show_all_users_path }
    assert_template 'html/home'

    # edit event  #grab even, pass 
    event = events(:event1)
    get_via_redirect edit_event_form_path(event), { controller: :html, action: :edit_event_form_path }
    assert_template 'html/login_form'
    
    # edit location
    location = locations(:location1)
    get_via_redirect edit_location_form_path(location), { controller: :html, action: :edit_location_form_path }
    assert_template 'html/home'
    
    # edit user
    user = users(:guest)
    get_via_redirect edit_user_form_path(user), { controller: :html, action: :edit_user_form_path }
    assert_template 'html/home'
    
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