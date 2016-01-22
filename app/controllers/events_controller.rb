class EventsController < ApplicationController
  def create_event
    @event = Event.new(event_params)

    if @event.save!
      @event.owner << @current_user

      Location.find(params['add_locations']).each do |location|
        unless @event.locations.include? location
          @event.locations << location
        end
      end

      redirect_to show_event_path(@event)
    else
      redirect_to new_event_path, alert: 'Event not created'
    end
  end

  def update_event
  end

  def delete_event
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end
end