class UserService

  def initialize
    @result = Hash.new
  end

  def search(query)
    return @result = {success: true, data: User.where("name like ?", "%#{query}%"), error: nil} if query
    return @result = {success: true, data: User.all, error: nil}
  end

  def follow_unfollow(user_id, current_user)
    user, flag = user(user_id), false
    if user && current_user.following?(user)
      current_user.unfollow(user)
      flag = true
    elsif user
      current_user.follow(user)
      flag = true
    end
    return @result = {success: true, data: '', error: nil} if flag
    return @result = {success: false, data: '', error: 'UNABLE TO FOLLOW UNFOLLOW THIS USER'}
  end

  private

  def user(id)
    User.find_by_id(id)
  end

end