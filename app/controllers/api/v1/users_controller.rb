class Api::V1::UsersController < Api::ApiController
	before_action :authenticate, except: [:create]

  def create
    user = User.new(user_params)
    if user.save
      user.update_columns(auth_token: user.token)
      render json: { user: user }, status: 200
    else
      render json: { error_messages: user.errors.messages}, status: 400
    end
  end

  def update
    @current_user.update(user_params)
    if @current_user.save
      render json: { user: @current_user }, status: 200
    else
      render json: { error_messages: @current_user.errors.messages}, status: 400
    end
  end

  def destroy
      @current_user.destroy
      render json: { message: "You deleted your account" }, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
