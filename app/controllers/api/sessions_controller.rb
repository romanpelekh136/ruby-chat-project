module Api
  class SessionsController < Api::BaseController
    skip_before_action :authenticate_api_user!, only: [ :create ]

    def create
      user = User.find(email: params[:email])

      if user&.valid_password?(params[:password])
        render json: { email: user.email, token: user.api_token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end
end
