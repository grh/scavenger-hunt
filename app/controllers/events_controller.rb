class EventsController < ApplicationController
  def create_event
    @event = Event.new(event_params)

    if @event.save?(params[:locations], @current_user)
      redirect_to show_event_path(@event)
    else
      flash[:danger] = 'Event not created'
      redirect_to new_event_form_path
    end
  end

  def update_event
    @event = Event.find(params[:id])

    if @event.update?(event_params, params[:locations])
      flash[:success] = 'Event updated successfully'
      redirect_to show_event_path(@event)
    else
      flash[:danger] = 'Event not updated'
      redirect_to edit_event_form_path(@event)
    end
  end

  def delete_event
    Event.destroy(params[:id]) ? flash[:success] = 'Event deleted' : flash[:danger] = 'Unable to delete event'
    redirect_to show_user_path(@current_user)
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end
end