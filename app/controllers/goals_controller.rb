class GoalsController < ApplicationController
  #before_action :set_goal, only: [:show, :update, :destroy]

  # GET /goals
  def index
    @goals = Goal.all

    render json: @goals
  end

  # GET /goals/1
  def show
    render json: @goal
  end

  # POST /goals
  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      #puts "I AM CURL SYS CALL" + system("curl http://localhost:9292/faye -d message={'channel':'/messages/new', 'data':'hello'}'").to_s
      #`curl http://localhost:9292/faye -d 'message={"channel":"/messages/new", "data":#{JSON.parse @goal}"}'`
      hash = []
      hash.push(@goal.title,@goal.email, @goal.id )
      `curl http://localhost:9292/faye -d 'message={"channel":"/messages/new", "data":"#{@goal.title.to_s+','+@goal.email.to_s+','+@goal.id.to_s}"}'`
      render json: @goal, status: :created, location: @goal
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /goals/1
  def update
    @goal = Goal.find_by_id params[:goal_id]
    if @goal and @goal.update(goal_params)
      render json: @goal
    else
      render json: 'SOMETHING WENT WRON!', status: :unprocessable_entity
    end
  end

  # DELETE /goals/1
  def destroy
    @goal = Goal.find_by_id params[:goal_id]
    if @goal and @goal.destroy
      render json: '', status: :created
    else
      render json: 'Goal Dont exist or something went wrong in deleting goal!', status: :unprocessable_entity
    end
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
