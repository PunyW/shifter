require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'has valid values and is saved to database' do
    subject { FactoryGirl.create(:user, username: 'admin', password: 'Admin123', password_confirmation: 'Admin123', email: 'admin@test.com') }

    it { should be_valid }
    its(:username) { should eq 'admin' }
    its(:email)    { should eq 'admin@test.com' }
    its(:password_digest) { should_not be nil }
  end

  describe 'with invalid value' do
    subject { User.create(username: 'admin', password:'admin123', password_confirmation: 'admin123', email: 'admin@test.com') }

    it { should be_invalid }
  end
end
