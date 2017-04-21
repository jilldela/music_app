class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to bands_url
    else
      flash[:errors] << "Invalid credentials"
      redirect_to new_user_url
    end
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
