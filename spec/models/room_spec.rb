require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:user) { create(:user) }
  it 'is valid with a name' do
    room = build(:room)
    expect(room).to be_valid
  end

  it 'is not valid without a name' do
    room = build(:room, name: nil)
    room.valid?

    expect(room.errors[:name]).to include("can't be blank")
  end

  it 'is not valid with the same name as another room' do
    create(:room, name: "Chess", user: user)
    room = build(:room, name: "Chess", user: user)

    expect(room).not_to be_valid
  end

  it 'is not valid without a user' do
    room = build(:room, user: nil)
    room.valid?

    expect(room.errors[:user]).to include("must exist")
  end

  it 'can have many messages' do
    room = create(:room, user: user)
    message = create(:message, room: room, user: user)
    expect(room.messages).to include(message)
  end

  it 'destroys associated message when Room is deleted' do
    room = create(:room, user: user)
    message = create(:message, room: room, user: user)

    expect { room.destroy }.to change(Message, :count).by(-1)
  end
end
