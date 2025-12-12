require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'is valid with a body, user and room' do
    message = build(:message)
    expect(message).to be_valid
  end
  it 'is invalid without a body' do
    message = build(:message, body: nil)
    message.valid?
    expect(message.errors[:body]).to include("can't be blank")
  end
  it 'is invalid without a user' do
    message = build(:message, user: nil)
    message.valid?
    expect(message.errors[:user]).to include("must exist")
  end
end
