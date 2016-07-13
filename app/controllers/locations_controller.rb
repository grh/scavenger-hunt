class LocationsController < ApplicationController
  def create_location
    @location = Location.new(location_params)

    if @location.create(location_params, @current_user)
      redirect_to show_location_path(@location)
    else
      flash[:danger] = Messages::ErrorMessages::UnableToCreateLocation
      render 'new_location_form'
    end
  end

  def update_location
    @location = Location.find(params[:id])

    if @location.update(location_params)
      flash[:success] = Messages::InfoMessages::LocationUpdatedSuccessfully
      redirect_to show_location_path(@location)
    else
      flash[:danger] = Messages::ErrorMessages::LocationNotUpdated
      redirect_to edit_location_form_path(@location)
    end
  end

  def delete_location
    @location = Location.find(params[:id])
    
    if @location.owner.include? @current_user or @current_user.admin? 
      if Location.destroy(@location) 
        flash[:success] = Messages::InfoMessages::LocationDeleted 
      else
        flash[:danger] = Messages::ErrorMessages::UnableToDeleteLocation
      end
    else
      flash[:danger] = Messages::ErrorMessages::UnableToDeleteLocation
    end

    if @current_user.admin?
      redirect_to show_all_locations_path
    else
      redirect_to show_user_path(@current_user)
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :description, :coordinates)
  end
end
