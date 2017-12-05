class CommentService

  def initialize
    @result = Hash.new
  end

  def index(goal_id)
    goal = Goal.find_by_id(goal_id)
    return @result = {success: true, data: goal.comments, error: nil} if goal
    return @result = {success: false, data: [], error: 'UNABLE TO FETCH GOAL COMMENTS!'}
  end

  def create(comment_params)
    goal = Goal.find_by_id(comment_params[:goal_id])
    comment = Comment.new(comment_params)
    return @result = {success: true, data: comment, error: nil} if goal and comment.save
    return @result = {success: false, data: [], error: 'UNABLE TO CREATE COMMENT!'}
  end

end