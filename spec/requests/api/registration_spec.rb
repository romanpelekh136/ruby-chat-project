require 'rails_helper'

RSpec.describe "Api::Registrations", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/registration/create"
      expect(response).to have_http_status(:success)
    end
  end

end
