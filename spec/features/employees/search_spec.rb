require 'rails_helper'

feature 'Looking for employees', js: true do
  before do
    Employee.create!(first_name: 'Kalam', last_name: 'Mekhar', work_percent: 1)
    Employee.create!(first_name: 'Ben', last_name: 'Quick', work_percent: 1)
    Employee.create!(first_name: 'Ganoes', last_name: 'Paron', work_percent: 1)

    visit '/'
  end

  scenario 'by default everyone is shown' do
    expect(page).to have_content 'Kalam'
    expect(page).to have_content 'Ben'
    expect(page).to have_content 'Ganoes'
  end

  scenario 'finding employee that exists' do
    fill_in 'keywords', with: 'kalam'
    click_on 'Search'

    expect(page).to have_content 'Kalam Mekhar'
  end

  scenario 'searching employee that doesn\'t exist' do
    fill_in 'keywords', with: 'pekka'
    click_on 'Search'

    expect(page).to have_content 'No employees found'
  end
end