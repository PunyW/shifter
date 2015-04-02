require 'rails_helper'

include TestUtils

feature 'Employee', js: true do
  describe 'logged in' do
    describe 'as admin' do
      let!(:user) { FactoryGirl.create(:user) }
      before :each do
        sign_in_capybara({ email: user.email, password: 'Admin123'})
      end

      feature 'form' do
        before do
          visit '/'
          click_on 'New employee...'
        end

        scenario 'invalid parameters' do
          fill_in 'first_name', with: ' '
          fill_in 'last_name', with: ' '
          fill_in 'work_percent', with: '101'

          expect(page).to have_content('First name is required')
          expect(page).to have_content('Last name is required')
          expect(page).to have_content('Enter number between 0 and 100')

          click_on 'Cancel'
          expect(page).to have_content('New employee...')
        end
      end

      feature 'new' do
        before do
          visit '/'
          click_on 'New employee...'
        end
        scenario 'create with valid parameters' do
          fill_in 'first_name', with: 'Ganoes'
          fill_in 'last_name', with: 'Paron'
          fill_in 'work_percent', with: 100

          click_on 'Save'

          expect(page).to have_content('Ganoes Paron')
          expect(page).to have_content('100%')
        end
      end

      feature 'existing' do
        before do
          FactoryGirl.create(:employee, first_name: 'Ganoes', last_name: 'Paron')
          visit '/'
          fill_in 'keywords', with: 'Paron'
          click_on 'Search'

          click_on 'Ganoes'
        end

        scenario 'edit' do
          click_on 'Edit'

          fill_in 'first_name', with: 'Felician'
          fill_in 'work_percent', with: 75

          click_on 'Save'

          expect(page).to have_content('Felician Paron')
          expect(page).to have_content('75%')

        end

        scenario 'delete' do
          click_on 'Delete'
          expect(page).to have_content('New employee...')
          expect(Employee.all.size).to eq 0
        end
      end
    end

    describe 'as normal user' do
      let!(:user) { FactoryGirl.create(:user, user_role: 0) }
      before :each do
        sign_in_capybara({ email: user.email, password: 'Admin123'})
      end

      feature 'new' do
        before do
          visit '/'
          click_on 'New employee...'
        end

        scenario 'access is denied' do
          expect(page).to have_content 'New employee...'
        end
      end
    end
  end

  describe 'logged out', focus: true do
    scenario 'accessing form' do
      visit '#/employees/new'
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end
  end
end