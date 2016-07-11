require 'test_helper'

class ParticipantTest < ActionDispatch::IntegrationTest
  test 'participant can view dashboard' do
    # login as participant
    user = login(:participant, show_user_path(users(:participant)))
    assert_template 'html/show_user'
  end

  test 'participant cannot view other accounts' do
    # login as participant
    user = login(:participant, show_user_path(users(:participant)))

    # try to access owner's account
    get_via_redirect show_user_path(users(:owner)), { controller: :html, action: :show_user }
    assert_template 'html/show_user'
    assert_equal Messages::ErrorMessages::UnauthorizedAccess, flash[:danger]
  end

  test 'participant cannot create account' do
    user = login(:participant, show_user_path(users(:participant)))

    # visit the create account page
    get_via_redirect signup_form_path, { controller: :html, action: :new_user_form }
    # verify that we weren't able to view the new user form
    assert_template 'html/show_user'
    assert_equal Messages::ErrorMessages::UnauthorizedAccess, flash[:danger]
  end

  test 'participant can view event' do
    # click on 'view event' as guest
    event = events(:event2)
    get_via_redirect show_event_path(event), { controller: :html, action: :show_event }
    assert_template 'html/login_form'

    # login as participant
    # verify redirected to event
    user = login(:participant, show_event_path(event))
    assert_template 'html/show_event'
  end

  test 'participant can join event' do
    # try to join as guest
    event = events(:event2)
    get_via_redirect join_event_path(event), { controller: :users, action: :join_event }
    assert_template 'html/login_form'

    # login as participant
    # verify joined event
    user = login(:participant, join_event_path(event))
    assert_template 'html/show_user'
    assert user.participating_events.include? event
  end

  test 'participant can visit location' do
    # make sure participant has joined event
    user = login(:participant, show_user_path(users(:participant)))
    event = events(:event2)
    user.participating_events << event
    get_via_redirect logout_path, { controller: :sessions, action: :delete }

    # scan the location QR code
    get_via_redirect visit_location_path(event.locations[0].tag), { controller: :users, action: :visit_location }
    assert_template 'html/login_form'

    # login as participant
    # verify location visited
    user = login(:participant, visit_location_path(event.locations[0].tag))
    assert_template 'html/show_user'
    assert user.visited_locations.include? event.locations[0]
  end

  test 'participant cannot visit location in event not joined' do
    # scan the location QR code
    event = events(:event2)
    get_via_redirect visit_location_path(event.locations[0].tag), { controller: :users, action: :visit_location }
    assert_template 'html/login_form'

    # login as participant
    # verify location visited
    user = login(:participant, visit_location_path(event.locations[0].tag))
    assert_template 'html/show_user'
    assert_not user.visited_locations.include? event.locations[0]
  end

  test 'participant can leave event' do
    # make sure participant has joined event
    user = users(:participant)
    event = events(:event2)
    user.participating_events << event

    # login as participant
    user = login(:participant, show_user_path(users(:participant)))

    # click on 'leave event' link
    get_via_redirect leave_event_path(event), { controller: :users, action: :leave_event }
    assert_template 'html/show_user'
    assert_not user.participating_events.include? event
  end

  test 'participant can edit own account' do
    # login as participant
    user = login(:participant, show_user_path(users(:participant)))

    # click on 'edit account' link
    get_via_redirect edit_user_form_path(user), { controller: :html, action: :edit_user_form }
    assert_template 'html/edit_user_form'

    # input changes to form and submit
    post_via_redirect update_user_path, {
        controller: :users,
        action: :update,
        user: {
            first_name: user.first_name,
            last_name: user.last_name,
            email: user.email,
            password: 'new_password',
            password_confirmation: 'new_password'
        }
    }
    assert_template 'html/show_user'
    assert_equal Messages::InfoMessages::AccountUpdatedSuccessfully, flash[:success]
  end

  test 'participant cannot edit other accounts' do
    # login as participant
    user = login(:participant, show_user_path(users(:participant)))

    # try to edit owner's account
    get_via_redirect edit_user_form_path(users(:owner)), { controller: :html, action: :edit_user_form }
    assert_template 'html/show_user'
    assert_equal Messages::ErrorMessages::UnauthorizedAccess, flash[:danger]
  end

  test 'participant can logout' do
    # login as participant
    user = login(:participant, logout_path)

    # click on 'logout' link
    get_via_redirect logout_path, { controller: :sessions, action: :delete }
    assert_template 'html/home'
  end
end