require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  test 'admin can create new user' do
    # login as admin
    admin = login(:admin, show_user_path(users(:admin)))

    # click on 'new user' link
    get_via_redirect new_user_form_path, { controller: :html, action: :new_user_form_path }
    assert_template 'html/new_user_form'

    # submit account information and
    # verify redirected to users admin
    new_user = User.new(
        first_name: 'New',
        last_name: 'User',
        email: 'new@user.com'
    )
    post_via_redirect create_user_path, {
        controller: :users,
        action: :create_user,
        user: {
            first_name: new_user.first_name,
            last_name: new_user.last_name,
            email: new_user.email,
            password: password,
            password_confirmation: password,
            role_ids: [roles(:participant).id]
        }
    }
    assert_template 'html/show_all_users'
    assert_equal new_user.email, User.last.email
    assert User.last.roles.include? Role.find_by_name('participant')
  end

  test 'admin can edit user' do
    # login as admin
    admin = login(:admin, show_user_path(users(:admin)))

    # click on 'edit user' link
    get_via_redirect edit_user_form_path, { controller: :html, action: :edit_user_form_path }
    assert_template 'html/edit_user_form'

    # submit account information and
    # verify redirected to users admin
    user = users(:participant)
    post_via_redirect update_user_path(user), {
        controller: :users,
        action: :create_user,
        user: {
            first_name: user.first_name,
            last_name: user.last_name,
            email: user.email,
            password: 'new_password',
            password_confirmation: 'new_password',
            role_ids: [roles(:participant).id]
        }
    }
    assert_template 'html/show_all_users'
  end

  test 'admin can delete user' do
    # login as admin
    admin = login(:admin, show_user_path(users(:admin)))

    # click on 'delete user' link
    user = users(:participant)
    get_via_redirect delete_user_path(user), { controller: :users, action: :delete_user }
    assert_template 'html/show_all_users'
  end

  test 'admin can create event' do
    # login as admin and
    # click on 'create event' link
    user = login(:admin, show_user_path(users(:admin)))
    get_via_redirect new_event_form_path, { controller: :html, action: :new_event_form }
    assert_template 'html/new_event_form'

    # submit the new event form
    # and redirect to event page
    new_event = Event.new(title: 'New Event', description: 'new event', start_date: Date.today, end_date: Date.tomorrow)
    post_via_redirect create_event_path, {
        controller: :event,
        action: :create_event,
        event: {
            title: new_event.title,
            description: new_event.description,
            start_date: new_event.start_date,
            end_date: new_event.end_date
        },
        locations: [locations(:location1).id]
    }
    assert_template 'html/show_event'
    assert Event.last.owner.include? user
  end

  test 'admin can edit event' do
    # login as admin and
    # click on 'edit event' link
    user = login(:admin, show_user_path(users(:admin)))
    event = events(:event2); event.description = 'new description'
    get_via_redirect edit_event_form_path(event), { controller: :html, action: :edit_event_form }
    assert_template 'html/edit_event_form'

    # update event information
    # and redirect to event page
    post_via_redirect update_event_path, {
        controller: :event,
        action: :update_event,
        event: {
            title: event.title,
            description: event.description,
            start_date: event.start_date,
            end_date: event.end_date
        },
        locations: [event.locations[0].id]
    }
    assert_template 'html/show_event'
    assert_equal Event.find(event.id), event
  end

  test 'admin can delete event' do
    # login as admin and
    # click on 'delete location' link
    user = login(:admin, show_user_path(users(:admin)))
    event = events(:event2)
    get_via_redirect delete_event_path(event), { controller: :events, action: :delete_event }
    assert_template 'html/show_all_events'
    assert_equal 'Event deleted', flash[:success]
  end

  test 'admin can create location' do
    # login as admin and
    # click on 'create location' link
    user = login(:admin, show_user_path(users(:admin)))
    get_via_redirect new_location_form_path, { controller: :html, action: :new_location_form }
    assert_template 'html/new_location_form'

    # submit the new location form
    # and redirect to location page
    new_location = Location.new(name: 'New Location', description: 'new location', coordinates: '36.107148, -115.14226')
    post_via_redirect create_location_path, {
        controller: :location,
        action: :create_location,
        location: {
            name: new_location.name,
            description: new_location.description,
            coordinates: new_location.coordinates
        }
    }
    assert_template 'html/show_location'
  end

  test 'admin can edit location' do
    # login as admin and
    # click on 'edit location' link
    user = login(:admin, show_user_path(users(:admin)))
    location = locations(:location1); location.description = 'new description'
    get_via_redirect edit_location_form_path(location), { controller: :html, action: :edit_location_form }
    assert_template 'html/edit_location_form'

    # update location information
    # and redirect to location page
    post_via_redirect update_location_path, {
        controller: :location,
        action: :update_location,
        location: {
            title: location.name,
            description: location.description,
            coordinates: location.coordinates
        }
    }
    assert_template 'html/show_location'
    assert_equal Location.find(location.id), location
  end

  test 'admin can delete location' do
    # login as admin and
    # click on 'delete location' link
    user = login(:admin, show_user_path(users(:admin)))
    location = locations(:location1)
    get_via_redirect delete_location_path(location), { controller: :locations, action: :delete_location }
    assert_template 'html/show_all_locations'
    assert_equal 'Location deleted', flash[:success]
  end
end
