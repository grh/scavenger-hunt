require 'test_helper'

class OwnerTest < ActionDispatch::IntegrationTest
  test 'owner can create event' do
    # click on 'create event' link
    user = login(:owner, show_user_path(users(:owner)))
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

  test 'owner can edit event' do
    # login as owner and
    # click on 'edit event' link
    user = login(:owner, show_user_path(users(:owner)))
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

  test 'owner can delete event' do
    # login as owner and
    # click on 'delete event' link
    user = login(:owner, show_user_path(users(:owner)))
    event = events(:event2); event.description = 'new description'
    get_via_redirect delete_event_path(event), { controller: :events, action: :delete_event }
    assert_template 'html/show_user'
    assert_equal Messages::InfoMessages::EventDeleted, flash[:success]
    assert_not Event.all.include? event
  end

  test 'owner can create location' do
    # click on 'create location' link
    user = login(:owner, show_user_path(users(:owner)))
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
    assert Location.last.owner.include? user
  end

  test 'owner can view location' do
    # login as owner
    user = login(:owner, show_user_path(users(:owner)))
    # click on 'view locatin' link
    location = locations(:location1)
    get_via_redirect show_location_path(location), { controller: :html, action: :show_location }
    assert_template 'html/show_location'
  end

  test 'owner can edit location' do
    # login as owner and
    # click on 'edit location' link
    user = login(:owner, show_user_path(users(:owner)))
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

  test 'owner can delete location' do
    # login as owner and
    # click on 'delete location' link
    user = login(:owner, show_user_path(users(:owner)))
    location = locations(:location1)
    get_via_redirect delete_location_path(location), { controller: :locations, action: :delete_location }
    assert_template 'html/show_user'
    assert_equal Messages::InfoMessages::LocationDeleted, flash[:success]
  end
end