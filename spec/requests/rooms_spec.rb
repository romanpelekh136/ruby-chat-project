require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let(:user) { create(:user) }

  before do
    names_for_rooms = %i[Chess Cars Fortnite Math Poker]
    names_for_rooms.each { |name| create(:room, name: name, user: user) }
  end
  describe "GET /index" do
    context 'when user signed in' do
      before { sign_in user, scope: :user }
      it 'returns all rooms' do
        get rooms_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Chess")
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get rooms_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /show" do
    before { sign_in user, scope: :user }

    context "with valid parameters" do
      it 'redirects to room page' do
        target_room = create(:room, user: user)
        create(:message, room: target_room, user: user, body: "Hello")
        get room_path(target_room)

        expect(response).to have_http_status(:success)
        expect(response.body).to include("Hello")
      end
    end

    context "with invalid parameters" do
      it 'returns :not_found' do
        missing_id = Room.maximum(:id).to_i + 1
        get room_path(missing_id)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Record not found.")
      end
    end
  end

  describe "POST /create" do
  end

  describe "DELETE /destroy" do
  end
end
