class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user

    @user ||= User.find(decoded_auth_token['user_id']) #if decoded_auth_token
    puts "failedddd***********************" if @user.nil?
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    #binding.pry
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    #puts "decoded_auth_token" + @decoded_auth_token.to_s
  end

  def http_auth_header
    if headers['Authorization'].present?
      puts "header Authorization ===>>>>>>>>>>>>>>>>>>>>>>>>" + headers['Authorization'].split(' ').last.to_s
      return headers['Authorization'].split(' ').last
    else
      puts "failedddd111111***********************"
      errors.add(:token, 'Missing token')
    end
    nil
  end

end
