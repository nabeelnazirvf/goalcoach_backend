class UsersController < ApplicationController

  # USER SIGNUP!
  def create
    @user = User.new(user_params)
    if @user.save
      access_token = JsonWebToken.encode(user_id: @user.id)
      render json: {user: @user, access_token: access_token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
