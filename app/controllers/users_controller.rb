class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :require_admin, only: %i[index destroy]
  # POST /signup
  # return authenticated token upon signup
  def index
    User.all
  end

  def create
    @user = User.new(user_params)
    @user.admin = true if User.first
    @user.save!
    auth_token = AuthenticateUser.new(@user.email, @user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    current_user.update!(user_params)
    json_response(current_user)
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def require_admin
    raise(ExceptionHandler::InvalidToken, Message.no_admin) unless current_user.admin
  end

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
