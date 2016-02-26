class OptionsController < ApplicationController
  def create_option
    if Option.create(option_params)
      flash[:success] = 'Options saved!'
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = 'Options not saved!'
      redirect_to new_option_form_path
    end
  end

  def update_option
    @option = Option.last
    if @option.update(option_params)
      flash[:success] = 'Options saved!'
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = 'Options not saved!'
      redirect_to new_option_form_path
    end
  end
  
  def option_params
    params.require(:option).permit(:color, :logo)
  end
end