class OptionsController < ActionController::Base

  def update_options
    @options = Option.last
    if @options.update(option_params)
      redirect_to show_all_users_path
    else
      flash[:danger] = 'View not updated'
    end
  end
  
  def option_params
    params.require(:option).permit(:color, :logo)
  end
end