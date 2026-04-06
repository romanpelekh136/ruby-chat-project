require 'rails_helper'

RSpec.describe "Api::Rooms", type: :request do
  describe "GET /api/rooms" do
    let!(:user) { create(:user, api_token: "token123") }
    let!(:room) { create(:room, name: "Arches") }

    context 'when user is logged in' do
      it 'returns rooms and code 200' do
        create_list(:room, 10, user: user)

        get api_rooms_path,
        headers: { "Authorization"=>"Bearer token123" }

        parsed_data = JSON.parse(response.body)

        expect(parsed_data.count).to eq(11)
        expect(response.body).to include("Arches")
        expect(response).to have_http_status(:ok)
      end
    end

    context 'whan user is not logged in' do
      it 'returns code 401' do
        get api_rooms_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
