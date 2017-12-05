class UsersController < ApplicationController
  before_action :set_user_service

  def index
    result = @user_service.search(user_params[:user][:search])
    render json: result[:data], include: ['users']
  end

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

  def update
    @user = User.find_by_email user_params[:user][:email]
    if @user and @user.update(user_params)
      render json: @user
    else
      render json: 'SOMETHING WENT WRONG!', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by_email(user_params[:user][:email]) || User.find_by_id(user_params[:user][:id])
    if @user
      render json: @user, current_user: @current_user, include: ['user']
    else
      render json: 'SOMETHING WENT WRONG!', status: :unprocessable_entity
    end
  end

  def follow_unfollow
    result = @user_service.follow_unfollow(user_params[:user][:user_id], @current_user)
    if result[:success]
      render json: :ok
    else
      render json: result[:error], status: :unprocessable_entity
    end
  end

  def user_activity
    user = User.find_by_id(user_params[:user][:id])
    goals = Goal.includes(:user, :comments)
    if user
      render json: user, root: "user", include: ['user', 'goals', 'goals.comments']
    else
      render json: 'SOMETHING WENT WRONG IN FETCHING USER ACTIVITY!', status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_base, :search, :user_id)
  end

  def set_user_service
    @user_service = UserService.new
  end


end
