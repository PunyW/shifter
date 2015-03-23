require 'rails_helper'
include TestUtils

RSpec.describe WorkShiftsController, type: :controller do
  render_views

  describe 'logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      sign_in_rspec(user.email)
    end

    describe 'index' do
      before do
        FactoryGirl.create(:work_shift)
        xhr :get, :index, format: :json
      end

      subject(:results) { JSON.parse(response.body) }

      context 'return work shifts' do
        it 'should 200' do
          expect(response.status).to eq 200
        end

        it 'should return 1 result' do
          expect(results.size).to eq 1
        end
      end
    end
  end

  describe 'logged out' do
    describe 'index' do
      before do
        xhr :get, :index, format: :json
      end

      it { expect(response.status).to eq 401 }
      it { expect(response.body).to eq '' }
    end
  end
end