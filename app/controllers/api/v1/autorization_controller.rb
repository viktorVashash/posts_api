class Api::V1::AutorizationController < Api::ApiController
  before_action :authenticate, except: [:login]
  include JwtConcern

  def login
    @user = User.where('lower(email) = ?', params[:email].downcase).first
    if @user && @user.authenticate(params[:password])
      @token = UserToken.create(user_id: @user.id)
      render json: {data: {token: @token, user: @user}}, status: 200
    else
      render json: {error_message: "Invalid email or password"}, status: 400
    end
  end

  def logout
    @current_user_token.destroy
    render json: {data: {mesage: "Success"}}, status: 200
  end

end
