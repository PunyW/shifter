require 'rails_helper'
include TestUtils

feature 'AdminPanel', js: true do
  describe 'shifts' do
    let!(:user) { FactoryGirl.create(:user)}
    before :each do
      FactoryGirl.create(:work_shift)
      sign_in_capybara({ email: user.email, password: 'Admin123' })
      visit '/#/admin'
      click_on 'Manage shifts'
    end

    feature 'landing page' do
      scenario 'list' do
        expect(page).to have_content 'Morning'
      end

      scenario 'editing shift' do
        click_on 'Morning'

        expect(page).to have_content 'Shift name'
        fill_in 'name', with: 'Night'
        click_on 'Save'

        expect(page).to have_content 'Night'
        expect(page).to have_content 'Shift was edited successfully'
      end
    end
  end
end