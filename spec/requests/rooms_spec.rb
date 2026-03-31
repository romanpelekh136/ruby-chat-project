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
    before { sign_in user, scope: :user }

    it 'successfully creates room' do
      expect {
        post rooms_path(format: :turbo_stream), params: { room: { name: "Gaming room" } }
      }.to change(Room, :count).by(1)

      expect(response).to have_http_status(:success)
    end

    it 'does not create a room with invalid params' do
      expect {
        post rooms_path(format: :turbo_stream), params: { room: { name: nil } }
      }.to change(Room, :count).by(0)

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /destroy" do
    let(:admin) { create(:user, role: 1) }
    let(:user) { create(:user) }
    context 'when user is the creator or an admin' do
      before do
        sign_in admin, scope: :user
      end
      it 'deletes room' do
        room = create(:room, user: user)

        expect {
          delete room_path(room, format: :turbo_stream)
        }.to change(Room, :count).by(-1)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not the creator or an admin' do
      before do
        sign_in user, scope: :user
      end
      it 'redirects to root and send alert' do
        room = create(:room, user: admin)

        expect {
          delete room_path(room, format: :turbo_stream)
        }.to change(Room, :count).by(0)
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end
  end

  describe "PATCH /rooms/:id" do
    let(:admin) { create(:user, role: 1) }
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, name: "Adastra fan club", user: user) }

    context 'when user is the creator or an admin' do
      before do
        sign_in admin, scope: :user
      end

      it 'updates the room name and returns success' do
        patch room_path(room, format: :turbo_stream), params: { room: { name: "New room name!" } }
        expect(response).to have_http_status(:success)
        expect(room.reload.name).to eq("New room name!")
      end
    end

    context 'when user is not the creator or an admin' do
      before do
        sign_in another_user, scope: :user
      end
      it 'redirects to home page and sends alert' do
        patch room_path(room, format: :turbo_stream), params: { room: { name: "New room name!" } }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorized to perform this action.")
      end
    end
  end
end
