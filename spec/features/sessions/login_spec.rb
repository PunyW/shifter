require 'rails_helper'

feature 'Login', js: true do
  before do
    FactoryGirl.create :user
    visit '/#/login'
  end

  scenario 'with correct credentials' do
    fill_in 'email', with: 'admin@test.com'
    fill_in 'password', with: 'Admin123'

    click_on 'Log in'

    expect(current_path).to eq '/'
  end

  scenario 'with incorrect credentials' do
    fill_in 'email', with: 'admin@admin.com'
    fill_in 'password', with: 'Admin123'

    click_on 'Log in'

    expect(page).to have_content 'Email/password combination invalid'
  end
end