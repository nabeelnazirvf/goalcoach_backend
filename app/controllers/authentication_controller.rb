class AuthenticationController < ApplicationController
  #prepend SimpleCommand
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { access_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def authenticate_by_access_token
    unless decoded_auth_token.nil?
      @user = User.find_by_id(decoded_auth_token['user_id'])
      if @user.present?
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: 'decoded_auth_token is nil', status: :unprocessable_entity
    end
  end

  private

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['token'].present?
      return -request.headers['token'].split(' ').last
    else
      nil
    end
    nil
  end
  
end