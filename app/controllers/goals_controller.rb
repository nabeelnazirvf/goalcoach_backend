class GoalsController < ApplicationController
  #before_action :set_goal, only: [:show, :update, :destroy]

  # GET /goals
  def index
    user = User.find_by_id(params[:user_id])
    if user
      @goals = user.goals.order(created_at: :desc)
      render json: @goals
    else

    end
  end

  # GET /goals/1
  def show
    render json: @goal
  end

  # POST /goals
  def create
    user = User.find_by_id(params[:user_id])
    @goal = user.goals.new(goal_params)
    if user && @goal.save
      render json: @goal, status: :created, location: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals/1
  def update
    @goal = Goal.find_by_id_and_user_id(params[:goal_id], params[:user_id])
    if @goal and @goal.update(goal_params)
      render json: @goal
    else
      render json: 'SOMETHING WENT WRONG IN UPDATING GOAL!', status: :unprocessable_entity
    end
  end

  # DELETE /goals/1
  def destroy
    @goal = Goal.find_by_id_and_user_id(params[:goal_id], params[:user_id])
    if @goal and @goal.destroy
      render json: '', status: :created
    else
      render json: 'Goal Dont exist or something went wrong in deleting goal!', status: :unprocessable_entity
    end
  end

  def goals_notifications
    goals_notifications = []
    Goal.includes(:user).order(created_at: :desc).each do |g|
      goals_notifications.push({user_name: g.user.name, image_base: g.user.image_base, title: g.title, created_at: g.created_at})
    end
    render json: goals_notifications
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def goal_params
      params.require(:goal).permit(:title, :email)
    end
end
