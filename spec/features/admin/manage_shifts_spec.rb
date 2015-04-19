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

      scenario 'click on shift' do
        click_on 'Morning'

        expect(page).to have_content 'Shift name'
      end
    end
  end
end