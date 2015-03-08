require 'rails_helper'

feature 'Looking for employees', js: true do
  scenario 'finding employee that exists' do
    visit '/'
    fill_in 'keywords', with: 'kalam'
    click_on 'Search'

    expect(page).to have_content 'Kalam Mekhar'
  end

  scenario 'searching employee that doesn\'t exist' do
    visit '/'
    fill_in 'keywords', with: 'pekka'
    click_on 'Search'

    puts(page)
    expect(page).to have_no_content 'Search results'
  end
end