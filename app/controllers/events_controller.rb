class EventsController < ApplicationController
  def create_event
    @event = Event.new(event_params)

    if @event.save?(params[:locations], @current_user)
      redirect_to show_event_path(@event)
    else
      flash[:danger] = Messages::ErrorMessages::EventNotCreated
      redirect_to new_event_form_path
    end
  end

  def update_event
    @event = Event.find(params[:id])

    if @event.update?(event_params, params[:locations])
      flash[:success] = Messages::InfoMessages::EventUpdatedSuccessfully
      redirect_to show_event_path(@event)
    else
      flash[:danger] = Messages::ErrorMessages::EventNotUpdated
      redirect_to edit_event_form_path(@event)
    end
  end

  def delete_event
    Event.destroy(params[:id]) ? flash[:success] = Messages::InfoMessages::EventDeleted : flash[:danger] = Messages::ErrorMessages::UnableToDeleteEvent
    if @current_user.admin?
      redirect_to show_all_events_path
    else
      redirect_to show_user_path(@current_user)
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end
end