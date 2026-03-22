require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a username' do
    user = build(:user, username: nil)

    expect(user).not_to be_valid
  end

  it 'defines the correct role mapping' do
    expect(User.roles).to eq({ "user" => 0, "admin" => 1 })
  end

  describe 'associations' do
    it 'has many messages' do
      expect(described_class.reflect_on_association(:messages).macro).to eq(:has_many)
    end

    it 'has many rooms' do
      expect(described_class.reflect_on_association(:rooms).macro).to eq(:has_many)
    end
  end
end
