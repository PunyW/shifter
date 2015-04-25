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

    describe 'create' do
      describe 'with valid attributes' do
        before do
          xhr :post, :create, format: :json, work_shift: {
              name: 'Morning',
              description: 'Morning shift',
              start_time: '7:00',
              end_time: '14:00',
              duration: 8,
              abbreviation: 'A'
            }
        end
        let(:work_shift) { WorkShift.last }

        it { expect(response.status).to eq 201 }
        it { expect(work_shift.name).to eq 'Morning' }
        it { expect(work_shift.description).to eq 'Morning shift' }
        it { expect(work_shift.start_time).to eq '7:00' }
        it { expect(work_shift.end_time).to eq '14:00' }
        it { expect(work_shift.duration).to eq 8 }
        it { expect(work_shift.abbreviation).to eq 'A'}
      end

      describe 'with invalid attributes' do
        before do
          xhr :post, :create, format: :json, work_shift: {
              name: '',
              description: 'Morning shift',
              start_time: '7:00',
              end_time: '14:00',
              duration: 8
            }
        end

        it { expect(response.status).to eq 422 }
        it { expect(WorkShift.all.length).to eq 0 }
      end
    end

    describe 'show' do
      before do
        xhr :get, :show, format: :json, id: work_shift.id
      end

      subject(:results) { JSON.parse(response.body) }

      context 'when the shift exists' do
        let(:work_shift) { FactoryGirl.create(:work_shift) }

        it { expect(response.status).to eq 200 }
        it { expect(results['id']).to eq work_shift.id }
        it { expect(results['name']).to eq work_shift.name }
        it { expect(results['description']).to eq work_shift.description }
        it { expect(results['duration']).to eq work_shift.duration }
        it { expect(results['start_time']).to eq work_shift.start_time }
        it { expect(results['end_time']).to eq work_shift.end_time }
      end
    end

    describe 'update' do
      let(:work_shift) { FactoryGirl.create(:work_shift) }

      describe 'with valid attributes' do
        before do
          xhr :put, :update, format: :json, id: work_shift.id, work_shift: {
              name: 'Night',
              description: 'Night shift',
              start_time: '21:00',
              end_time: '07:00',
              duration: 10
            }
          work_shift.reload
        end

        it { expect(response.status).to eq 204 }
        it { expect(work_shift.name).to eq 'Night' }
        it { expect(work_shift.description).to eq 'Night shift' }
        it { expect(work_shift.start_time).to eq '21:00' }
        it { expect(work_shift.end_time).to eq '07:00' }
        it { expect(work_shift.duration).to eq 10 }
      end

      describe 'with invalid attributes' do
        before do
          xhr :put, :update, format: :json, id: work_shift.id, work_shift: {
              name: ''
            }
        end

        it { expect(response.status).to eq 422 }
        it { expect(work_shift.name).to eq 'Morning' }
      end
    end

    describe 'destroy' do
      let(:work_shift) { FactoryGirl.create(:work_shift) }

      before do
        xhr :delete, :destroy, format: :json, id: work_shift.id
      end

      it { expect(response.status).to eq 204 }
      it { expect(WorkShift.find_by_id(work_shift.id)).to eq nil }
    end

    describe "destroy shift that doesn't exist" do
      before do
        xhr :delete, :destroy, format: :json, id: 999
      end

      it { expect(response.status).to eq 404 }
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

    describe 'show' do
      before do
        xhr :get, :show, format: :json, id: work_shift.id
      end

      let(:work_shift) { FactoryGirl.create(:work_shift) }

      it { expect(response.status).to eq 401 }
      it { expect(response.body).to eq '' }
    end

    describe 'create' do
      before do
        xhr :post, :create, format: :json, work_shift: {
            name: 'Night',
            description: 'Night shift',
            start_time: '21:00',
            end_time: '07:00',
            duration: 10
          }
      end

      it { expect(response.status).to eq 401 }
      it { expect(WorkShift.all.length).to eq 0 }
    end

    describe 'update ' do
      let(:work_shift) { FactoryGirl.create(:work_shift) }

      before do
        xhr :put, :update, format: :json, id: work_shift.id, work_shift: {
            name: 'Night'
          }
      end

      it { expect(response.status).to eq 401 }
    end

    describe 'destroy' do
      let(:work_shift) { FactoryGirl.create(:work_shift) }

      before do
        xhr :delete, :destroy, format: :json, id: work_shift.id
      end

      it { expect(response.status).to eq 401 }
    end
  end
end