class GoalsController < ApplicationController

  # GET /goals
  def index
    @goal_service = GoalService.new(goal_params,'index')
    command = @goal_service.call
    if command.success?
      render json: command.result.to_a, include: ['goals']
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # GET /goals/1
  def show
    @goal_service = GoalService.new(goal_params, 'show')
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # POST /goals
  def create
    @goal_service = GoalService.new(goal_params, 'create')
    command = @goal_service.call
    if command.success?
      render json: command.result, include: ['goal']
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals/1
  def update
    @goal_service = GoalService.new(goal_params, 'update')
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /goals/1
  def destroy
    @goal_service = GoalService.new(goal_params, 'destroy')
    command = @goal_service.call
    if command.success?
      render json: ''
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  def goals_notifications
    @goal_service = GoalService.new(goal_params, 'goals_notifications')
    command = @goal_service.call
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :email, :user_id, :goal_id)
  end

end