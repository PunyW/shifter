require 'rails_helper'

include TestUtils

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'logged out' do
    describe 'create' do
      describe 'with valid attributes' do
        before do
          xhr :post, :create, format: :json, user: {
              username: 'jaska',
              password: 'Tos1HyvaSalasana',
              password_confirmation: 'Tos1HyvaSalasana',
              email: 'jaska@jaskankujeet.fi'
            }
        end

        it { expect(response.status).to eq 201 }
        it { expect(User.last.username).to eq 'jaska' }
      end

      describe 'with invalid attributes' do
        before do
          xhr :post, :create, format: :json, user: {
              username: 'jaska',
              password: 'badpw',
              password_confirmation: 'badpw',
              email: 'jaska@jaskankujeet.fi'
            }
        end

        it { expect(response.status).to eq 422 }
        it { expect(User.all.length).to eq 0 }
      end
    end

    describe 'update' do
      let!(:user) { FactoryGirl.create(:user) }
      before do
        xhr :put, :update, format: :json, id: user.id, user: {
            username: 'test'
          }
      end

      it { expect(response.status).to eq 401 }
      it { expect(User.last.username).to eq 'admin' }

    end
  end

  describe 'logged in as admin' do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      sign_in_rspec(user.email)
    end

    describe 'create' do
      describe 'with valid attributes' do
        before do
          xhr :post, :create, format: :json, user: {
              username: 'jaska',
              password: 'Tos1HyvaSalasana',
              password_confirmation: 'Tos1HyvaSalasana',
              email: 'jaska@jaskankujeet.fi'
            }
        end

        it { expect(response.status).to eq 201 }
        it { expect(User.last.username).to eq 'jaska' }
      end

      describe 'with invalid attributes' do
        before do
          xhr :post, :create, format: :json, user: {
              username: 'jaska',
              password: 'badpw',
              password_confirmation: 'badpw',
              email: 'jaska@jaskankujeet.fi'
            }
        end

        it { expect(response.status).to eq 422 }
        it { expect(User.all.length).to eq 1 }
      end
    end

    describe 'update' do
      describe 'with valid attributes' do
        before do
          xhr :put, :update, format: :json, id: user.id, user: {
              username: 'Master'
            }
          user.reload
        end

        it { expect(response.status).to eq 200 }
        it { expect(user.username).to eq 'Master' }
      end

      describe 'with invalid attributes' do
        before do
          xhr :put, :update, format: :json, id: user.id, user: {
              username: 'a'
            }
          user.reload
        end

        it { expect(response.status).to eq 422 }
        it { expect(user.username).to eq 'admin' }
      end
    end
  end
end