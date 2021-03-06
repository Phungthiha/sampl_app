class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "users_controller.wl"
      redirect_to @user
    else
      flash[:danger] = t "users_controller.fails"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user.present?
    flash[:error] = t ".not"
    redirect_to :signup_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
