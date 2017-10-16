class GoalsController < ApplicationController
  #before_action :set_service_object, only: [:index, :show, :update, :destroy, :create, :goals_notifications]

  METHODS = ["index","show","create","update","destroy","goals_notifications"]

  METHODS.each do |method|
    define_method "#{method}" do
      @goal_service = GoalService.new(params[:user_id], params[:goal_id], "#{method}", goal_params)
      command = @goal_service.call
      if command.success?
        render json: command.result
      else
        render json: { error: command.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def goal_params
    if params[:goal].present?
      params.require(:goal).permit(:title, :email, :user_id)
    else
      return nil
    end
  end

end