class SessionsController < ApplicationController
  def create_session
    @user = User.authenticate(user_params)
    if login(@user)
      redirect_to params[:redirect_to]
    else
      #flash.now[:danger] = 'Invalid email or password'
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