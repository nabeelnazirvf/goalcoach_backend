class GoalsController < ApplicationController
  #before_action :set_service_object, only: [:index, :show, :update, :destroy, :create, :goals_notifications]

  # GET /goals
  def index
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'index', nil)
    command = @goal_service.call
    if command.success?
      render json: command.result.to_a
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # GET /goals/1
  def show
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'show', nil)
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # POST /goals
  def create
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'create', goal_params)
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals/1
  def update
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'update', goal_params)
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /goals/1
  def destroy
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'destroy', nil)
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  def goals_notifications
    @goal_service = GoalService.new(params[:user_id], params[:goal_id], 'goals_notifications', nil)
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  private
    # def set_service_object
    #   @goal_service = GoalService.new(params[:user_id], params[:goal_id], nil, nil)
    # end

    # Only allow a trusted parameter "white list" through.
    def goal_params
      params.require(:goal).permit(:title, :email, :user_id)
    end

    

end