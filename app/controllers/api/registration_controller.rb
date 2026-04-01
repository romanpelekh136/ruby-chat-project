module Api
  class RegistrationController < Api::BaseController
    skip_before_action :authenticate_api_user!, only: [ :create ]

    def create
      user = User.new(user_params)

      if user.save
        render json: { email: user.email, api_token: user.api_token }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
  end
end
