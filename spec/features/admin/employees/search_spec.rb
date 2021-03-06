require 'rails_helper'
include TestUtils

feature 'Looking for employees', js: true do
  describe 'When logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    before :each do
      Employee.create!(first_name: 'Kalam', last_name: 'Mekhar', work_percent: 1)
      Employee.create!(first_name: 'Ben', last_name: 'Quick', work_percent: 1)
      Employee.create!(first_name: 'Ganoes', last_name: 'Paron', work_percent: 1)
      sign_in_capybara({ email: user.email, password: 'Admin123'})
      visit '/#/admin/employees'
    end

    scenario 'by default everyone is shown' do
      find('.employee-list').find('ul')
      expect(page).to have_content 'Kalam'
      expect(page).to have_content 'Ben'
      expect(page).to have_content 'Ganoes'
    end

    scenario 'finding employee that exists' do
      fill_in 'search', with: 'kalam'

      expect(page).to have_content 'Mekhar Kalam'
    end

    scenario 'searching employee that doesn\'t exist' do
      fill_in 'search', with: 'pekka'
      find('.employee-list').find('ul')

      expect(page).to have_no_content 'Kalam'
      expect(page).to have_no_content 'Quick'
      expect(page).to have_no_content 'Paron'
    end
  end
end