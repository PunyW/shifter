require 'rails_helper'

include TestUtils

feature 'Viewing an employee', js: true do
  describe 'When logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in_capybara({ email: user.email, password: 'Admin123'})
      FactoryGirl.create :employee
      FactoryGirl.create(:employee, first_name: 'Ganoes', last_name: 'Paron')
    end

    scenario 'view employee page' do
      visit '/'
      fill_in 'keywords', with: 'Kalam'
      click_on 'Search'

      click_on 'Kalam'

      expect(page).to have_content('Kalam Mekhar')
      expect(page).to have_content('100%')

      click_on 'Back'

      expect(page).to have_content('Kalam Mekhar')
      expect(page).to_not have_content('100%')

    end
  end
end