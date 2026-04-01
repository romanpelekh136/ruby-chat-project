module Api
  class BaseController < ActionController::API
    before_action :authenticate_api_user!

    private

    def authenticate_api_user!
      token = request.headers["Authorization"]&.split(" ")&.last

      @current_user = User.find_by(api_token: token)

      unless @current_user
        render json: { error: "Unauthorized access" }, status: :unauthorized
      end
    end

    def current_user
      @current_user
    end
  end
end
