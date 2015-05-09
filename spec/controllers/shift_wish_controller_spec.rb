require 'rails_helper'
include TestUtils

RSpec.describe ShiftWishController, type: :controller do
  render_views
  describe 'logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:work_shift) { FactoryGirl.create(:work_shift) }
    let!(:employee) { FactoryGirl.create(:employee) }
    before do
      sign_in_rspec(user.email)
    end

    describe 'index' do
      before do
        FactoryGirl.create(:shift_wish, work_shift_id: work_shift.id, employee_id: employee.id)
        xhr :get, :index, format: :json
      end

      subject(:results) { JSON.parse(response.body) }

      context 'returns shift wish' do
        it 'should return 200' do
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
          xhr :post, :create, format: :json, shift_wish: {
              employee_id: employee.id,
              work_shift_id: work_shift.id,
              date_number: 1,
              month_number: 1
            }
        end

        let(:wish) { ShiftWish.last }

        it { expect(response.status).to eq 201 }
        it { expect(wish.employee).to eq employee }
        it { expect(wish.work_shift).to eq work_shift }
        it { expect(wish.date_number).to eq 1 }
        it { expect(wish.month_number).to eq 1 }
      end
    end

    describe 'update' do
      let(:shift_wish) { FactoryGirl.create(:shift_wish) }
      let(:night) { FactoryGirl.create(:work_shift, name: 'Night') }
      before do
        xhr :put, :update, format: :json, id: shift_wish.id, shift_wish: {
            work_shift_id: night.id
          }
        shift_wish.reload
      end

      it { expect(response.status).to eq 204 }
      it { expect(shift_wish.work_shift).to eq night }
    end
  end

end