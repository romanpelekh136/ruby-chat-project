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
end
