require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many messages' do
      expect(described_class.reflect_on_association(:messages).macro).to eq(:has_many)
    end
  end
end
