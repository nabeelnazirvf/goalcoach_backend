class UsersController < ApplicationController
  before_action :set_user_service

  def index
    result = @user_service.search(params[:search])
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
    @user = User.find_by_email params[:email]
    if @user and @user.update(user_params)
      render json: @user
    else
      render json: 'SOMETHING WENT WRONG!', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by_email(params[:email]) || User.find_by_id(params[:id])
    if @user
      render json: @user, include: ['user']#, serializer: Users::ShowSerializer
    else
      render json: 'SOMETHING WENT WRONG!', status: :unprocessable_entity
    end
  end

  def user_activity
    user = User.find_by_id(params[:id])
    #user_activity = User.where(id: user.id).includes(:goals, :comments).order(created_at: :desc).to_a
    goals = Goal.includes(:user, :comments)
    # from_time = Time.now
    # render json: {user: user, date: ActionView::Base.new.distance_of_time_in_words(from_time, Goal.last.created_at.to_time + (1440*100).minutes)}
    if user
      render json: user, root: "user", include: ['user', 'goals', 'goals.comments']#, serializer: Users::ShowSerializer
    else
      render json: 'SOMETHING WENT WRONG IN FETCHING USER ACTIVITY!', status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_base)
  end

  def set_user_service
    @user_service = UserService.new
  end


end
