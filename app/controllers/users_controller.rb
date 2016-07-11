class UsersController < ApplicationController

  skip_before_action :install, only: :create_user

  def create_user
    @user = User.new(user_params)

    if @user.create
      if @current_user.admin? or (@current_user.guest? and @user.admin?)
        if User.last.admin? and User.admins.size == 1
          login(@user)
          redirect_to new_option_form_path
        else
          redirect_to show_all_users_path
        end
      else
        login(@user)
        redirect_to show_user_path(@user)
      end
    else
      flash.now[:danger] = Messages::ErrorMessages::AccountNotCreated
      render 'html/new_user_form'
    end
  end

  def update_user
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = Messages::InfoMessages::AccountUpdatedSuccessfully
      if @current_user.admin?
        redirect_to show_all_users_path
      else
        redirect_to show_user_path(@user)
      end
    else
      flash[:danger] = Messages::ErrorMessages::AccountNotUpdated
      redirect_to edit_user_form_path(@user)
    end
  end

  def delete_user
    User.destroy(params[:id]) ? flash[:success] = Messages::InfoMessages::AccountDeleted : flash[:danger] = Messages::ErrorMessages::UnableToDeleteEvent
    if @current_user.admin?
      redirect_to show_all_users_path
    else
      redirect_to root_path
    end
  end

  def join_event
    if @current_user.guest?
      flash[:danger] = Messages::ErrorMessages::YouMustBeLoggedInToJoinAnEvent
      redirect_to login_form_path
    else
      if @current_user.join Event.find(params[:event_id])
        redirect_to show_user_path(@current_user)
      else
        flash[:danger] = Messages::ErrorMessages::UnableToJoinEvent
        redirect_to show_user_path(@current_user)
      end
    end
  end

  def leave_event
    @event = Event.find(params[:event_id])

    if @current_user.leave(@event)
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = Messages::ErrorMessages::UnableToLeaveEvent
      redirect_to show_event_path(@event)
    end
  end

  def visit_location
    if @current_user.visit Location.find_by_tag(params[:tag])
      flash[:success] = Messages::InfoMessages::SuccessfulCheckIn
      redirect_to show_user_path(@current_user)
    else
      flash[:danger] = Messages::ErrorMessages::ErrorCheckingIn
      redirect_to show_user_path(@current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, role_ids: [])
  end
end
