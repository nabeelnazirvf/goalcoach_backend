class GoalService
  prepend SimpleCommand

  def initialize(desired_params, method_type)
    @user_id = desired_params[:user_id]
    @goal_id = desired_params[:goal_id]
    @method_type = method_type
    @goal_params = desired_params
  end

  def call
    case @method_type
      when 'index'
        goals
      when 'show'
        show
      when 'update'
        update
      when 'destroy'
        destroy
      when 'create'
        create
      when 'goals_notifications'
        goals_notifications
      else
        goals
    end
  end

  private

  def user
    u = User.find_by_id(@user_id)
    return u if u
    errors.add :user, 'User Not Found!'
    nil
  end

  def goals
    desired_user = user
    if desired_user
      multual_goals = []
      user_ids = desired_user.following.pluck(:id)
      user_ids.push(desired_user.id)
      multual_goals = Goal.where(user_id: user_ids).order(created_at: :desc)
      return multual_goals
    end
    errors.add :user, 'User Not Found!'
    nil
  end

  def create
    if user
      goal = user.goals.new(@goal_params)
      return goal if goal.save
      errors.add :goal, 'Unable to create goal!'
      nil
    else
      errors.add :user, 'User Not Found!'
      nil
    end
  end

  def update
    goal = Goal.find_by_id_and_user_id(@goal_id, @user_id)
    if user && goal
      return goal if goal.update(@goal_params)
      errors.add :goal, 'Unable to update goal!'
      nil
    else
      errors.add :user, 'User or Goal Not Found!'
      nil
    end
  end

  def destroy
    goal = Goal.find_by_id_and_user_id(@goal_id, @user_id)
    if user && goal
      return goal if goal.destroy
      errors.add :goal, 'Unable to delete goal!'
      nil
    else
      errors.add :user, 'User or Goal Not Found!'
      nil
    end
  end

  def goals_notifications
    goals_notifications = []
    Goal.includes(:user).order(created_at: :desc).each do |g|
      goals_notifications.push({user_name: g.user.name, image_base: g.user.image_base, title: g.title, created_at: g.created_at})
    end
    goals_notifications
  end

end