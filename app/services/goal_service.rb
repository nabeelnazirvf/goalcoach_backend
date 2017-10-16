class GoalService
  prepend SimpleCommand

  def initialize(user_id, goal_id, method_type, goal_params)
    @user_id = user_id
    @goal_id = goal_id
    @method_type = method_type
    @goal_params = goal_params
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

  #attr_accessor :user_id, :goal_id

  def user
    u = User.find_by_id(@user_id)
    return u if u
    errors.add :user, 'User Not Found!'
    nil
  end

  def goals
    return user.goals.order(created_at: :desc) if user
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