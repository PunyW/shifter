require 'rails_helper'

include TestUtils

RSpec.describe ListsController, type: :controller do
  render_views

  describe 'logged in' do
    describe 'as admin' do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        sign_in_rspec(user.email)
      end

      describe 'create' do
        describe 'with valid attributes' do
          before do
            xhr :post, :create, format: :json, list: {
                number: 1,
                length: 3,
                start_date: '2015-04-27',
                end_date: '2015-05-11'
              }
          end

          it { expect(response.status).to eq 201 }
          it { expect(List.last.start_date).to eq Date.parse('2015-04-27') }
          it { expect(List.last.end_date).to eq Date.parse('2015-05-11') }
          it { expect(List.last.number).to eq 1 }
          it { expect(List.last.length).to eq 3 }
        end

        describe 'with invalid attributes' do
          before do
            xhr :post, :create, format: :json, list: {
                number: ' ',
                length: ' ',
                start_date: ' ',
                end_date: ' '
              }
          end

          it { expect(response.status).to eq 422 }
        end
      end
    end
  end

  describe 'logged out' do
    describe 'create' do
      before do
        before do
          xhr :post, :create, format: :json, list: {
              number: 1,
              length: 3,
              start_date: '2015-04-27',
              end_date: '2015-05-11'
            }
        end

        it { expect(response.status).to eq 401 }
      end
    end
  end
end