require 'rails_helper'
include TestUtils

feature 'AdminPanel', js: true do
  feature 'admin logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in_capybara({ email: user.email, password: 'Admin123' })
      visit '/#/admin'
    end

    scenario 'landing page' do
      expect(page).to have_content 'Manage employees'
      expect(page).to have_content 'Manage shifts'
    end
  end
end