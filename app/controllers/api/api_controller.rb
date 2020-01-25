class Api::ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate
    set_current_user
      if @current_user_token.nil?
        render json: { error_message:  'Token expired'},  status: 401
        return
      end
  end

  def set_current_user
    user_token = UserToken.find_by(auth_token: request.headers['Authorization'])
    if user_token
       @current_user_token = user_token
       @current_user       = user_token.user
    end
  end

  def current_user
    @current_user
  end

  private

  def user_not_authorized
    render json: { data: { message: 'You are not authorized to perform this action.' } }, status: 401
  end
end
