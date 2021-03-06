require 'rails_helper'

include TestUtils

feature 'Employee', js: true do
  describe 'logged in' do
    describe 'as admin' do
      let!(:user) { FactoryGirl.create(:user) }
      before :each do
        sign_in_capybara({ email: user.email, password: 'Admin123' })
      end

      feature 'form' do
        before do
          visit '/#/admin/employees'
          click_on 'New employee...'
        end

        scenario 'invalid parameters' do
          fill_in 'firstName', with: ' '
          fill_in 'lastName', with: ' '
          fill_in 'workPercent', with: '101'

          expect(page).to have_content('First name is required')
          expect(page).to have_content('Last name is required')
          expect(page).to have_content('Enter number between 0 and 100')

          expect(page).to have_button('Save', disabled: true)
        end
      end

      feature 'new' do
        before do
          visit '/#/admin/employees'
          click_on 'New employee...'
        end
        scenario 'create with valid parameters' do
          fill_in 'firstName', with: 'Ganoes'
          fill_in 'lastName', with: 'Paron'
          fill_in 'workPercent', with: 100

          click_on 'Save'

          find('.employee-list').find('ul')
          expect(page).to have_content 'Ganoes'
        end
      end

      feature 'existing' do
        before do
          FactoryGirl.create(:employee, first_name: 'Ganoes', last_name: 'Paron')
          visit '/#/admin/employees'
          find('.employee-list').find('ul')
          click_on 'Paron Ganoes'
        end

        scenario 'edit' do
          fill_in 'firstName', with: 'Felician'
          fill_in 'workPercent', with: 75

          click_on 'Save'

          expect(page).to have_content 'Felician'
        end
      end
    end
  end
end