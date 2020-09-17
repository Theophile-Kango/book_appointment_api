class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :require_admin, only: %i[index destroy]
  # POST /signup
  # return authenticated token upon signup
  def index 
    users = User.all 
  end
  def create
    @user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    @user.update!(user_params)
    json_response(@user)
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :email, :password_digest, :image)
  end

  def require_admin
    raise(ExceptionHandler::InvalidToken, Message.no_admin) unless current_user.admin
  end
  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin,
      :image,
      :isDoctor
    )
  end
end
