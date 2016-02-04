class UsersController < ApplicationController

  skip_before_action :install, only: :create_user

  def create_user
    @user = User.new(user_params)

    if @user.create
      if login(@user)
        redirect_to show_user_path(@user)
      else
        flash[:danger] = 'Error with new user account'
        render 'new_user_form'
      end
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new_user_form'
    end
  end

  def update_user
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Account updated successfully'
      redirect_to show_user_path(@user)
    else
      flash[:danger] = 'Account not updated'
      redirect_to edit_user_form_path(@user)
    end
  end

  def delete_user
  end

  def join_event
    if @current_user.guest?
      flash[:danger] = 'You must be logged in to join an event'
      redirect_to login_form_path
    else
      if @current_user.join Event.find(params[:event_id])
        redirect_to show_user_path(@current_user)
      else
        flash[:danger] = 'Unable to join event'
        redirect_to show_user_path(@current_user)
      end
    end
  end

  def leave_event
    @event = Event.find(params[:event_id])

    if @current_user.leave(@event)
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = 'Unable to leave event'
      redirect_to show_event_path(@event)
    end
  end

  def visit_location
    if @current_user.visit Location.find_by_tag(params[:tag])
      flash[:success] = 'Successful check in'
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = 'Error checking in'
      redirect_to show_user_path(@current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
