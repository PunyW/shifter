require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  describe 'create' do
    let!(:user) { FactoryGirl.create(:user) }

    describe 'with correct credentials' do
      before do
        xhr :post, :create, format: :json, email: 'admin@test.com', password: 'Admin123'
      end

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to include 'admin' }
    end

    describe 'with incorrect credentials' do
      before do
        xhr :post, :create, format: :json, email: 'admin@test.com', password: 'WrongPassword1'
      end

      it { expect(response.status).to eq 401}
    end
  end
end