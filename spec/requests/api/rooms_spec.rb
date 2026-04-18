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

  describe "GET /api/rooms/id" do
    let!(:user) { create(:user, api_token: "token123") }
    let(:room) { create(:room, user: user, name: "Adastra") }
    context 'when user logged in' do
      it 'returns room' do
        get api_rooms_path(room),
        headers: { "Authorization"=>"Bearer token123" }
        expect(response.body). to include("Adastra")
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when user is not logged in' do
      it 'returns code :unauthorized' do
        get api_rooms_path(room)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end


  describe "POST /api/rooms/" do
    let!(:user) { create(:user, api_token: "token123") }

    context 'when user is logged in' do
      it "creates a room" do
        expect { post api_rooms_path,
        headers: { "Authorization"=>"Bearer token123" },
        params: { room: { name: "Adastra" } }}.to change(Room, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
    context 'when user is not logged in' do
      it 'returns code "unauthorized' do
        post api_rooms_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/rooms/id" do
    let!(:user) { create(:user, api_token: "token123") }
    let!(:another_user) { create(:user, api_token: "another_token") }
    let!(:room) { create(:room, name: "Blur", user: user) }

    context 'when user is logged in' do
      it 'deletes successfully' do
        expect {
          delete api_room_path(room),
          headers: { "Authorization"=>"Bearer token123" }
        }.to change(Room, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when user is not a creator of a room' do
    end
    context 'when user is not logged in' do
      it 'returns code "unauthorized' do
        delete api_room_path(room)

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
