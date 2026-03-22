require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "POST /create" do
    let(:user) { create(:user) }
    let(:room) { create(:room, user: user) }

    context 'when user is signed in' do
      before { sign_in user, scope: :user }

      context 'with valid body' do
        it 'returns http success' do
          post room_messages_path(room, format: :turbo_stream), params: { message: { body: "Hello" } }
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid body' do
        it 'returns http unprocesable entity' do
          post room_messages_path(room), params: { message: { body: nil } }
          expect(response).to have_http_status(:unprocessable_content)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        post room_messages_path(room, format: :turbo_stream), params: { message: { body: "Hello" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
