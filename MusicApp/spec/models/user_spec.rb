require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: 'jill@cool.com', password: 'password')}

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }

    it "creates password_digest" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      user.valid?
      expect(user.session_token).to_not be_nil
    end
  end

  describe '#is_password?' do
    it "verifies password matches user password" do
      expect(user.is_password?('password')).to be true
    end
  end

  describe '#reset_session_token!' do
    it "sets new session token for user" do
      user.valid?
      old_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_token)
    end
    it "returns new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    it 'returns user if credentials are good' do
      expect(User.find_by_credentials('jill@cool.com', 'password')).to eq(user)
    end

    it 'returns nil if credentials are bad' do
      expect(User.find_by_credentials('jill@cool.com', 'hunter12')).to be nil
    end
  end

end
