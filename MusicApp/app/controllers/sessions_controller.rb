class SessionsController < ApplicationController

  def create
    email, password = session_params.values
    user = User.find_by_credentials(email, password)

    if user
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] << "Invalid username or password"
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    logout
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
