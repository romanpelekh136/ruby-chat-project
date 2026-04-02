module ApiErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  end

  private

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_standard_error(exception)
    raise exception if Rails.env.development?
    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end
