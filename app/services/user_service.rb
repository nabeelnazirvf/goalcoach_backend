class UserService

  def initialize
    @result = Hash.new
  end

  def search(query)
    # binding.pry
    return @result = {success: true, data: User.where("name like ?", "%#{query}%"), error: nil} if query
    return @result = {success: true, data: User.all, error: nil}
  end

end