require 'test_helper'

class OwnerTest < ActionDispatch::IntegrationTest
  test 'owner can create event' do
    # click on 'create event' link
    user = login(:owner, show_user_path(users(:owner)))
    get_via_redirect new_event_form_path, { controller: :html, action: :new_event_form }
    assert_template 'html/new_event_form'

    # submit the new event form
    # and redirect to dashboard
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
        add_locations: [locations(:location1).id]
    }
    assert_template 'html/show_event'
    assert Event.last.owner.include? user
  end
end