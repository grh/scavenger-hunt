class SessionsController < ApplicationController
  def create_session
    @user = User.authenticate(user_params)
    if @user
      login(@user)
      if params[:redirect_to].empty?
        redirect_to show_user_path(@user)
      else
        redirect_to params[:redirect_to]
      end
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'html/login_form'
    end
  end

  def update_session
    logout
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end