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
      scenario 'table' do
        expect(page).to have_content 'Morning'
        expect(page).to have_content '8 am'
      end

      scenario 'click on shift' do
        within 'table' do
          find('td', text: 'Morning').click
        end

        expect(page).to have_content 'Morning shift'
      end
    end
  end
end