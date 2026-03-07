require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'is valid with a name' do
    room = build(:room)
    expect(room).to be_valid
  end

  it 'is not valid without a name' do
    room = build(:room, name: nil)
    room.valid?

    expect(room.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without a user' do
    room = build(:room, user: nil)
    room.valid?

    expect(room.errors[:user]).to include("must exist")
  end

  it 'can have many messages' do
    room = create(:room)
    message = create(:message, room: room)
    expect(room.messages).to include(message)
  end
end
