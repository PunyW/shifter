require 'rails_helper'

feature 'Employee', js: true do
  scenario 'create new' do
    visit '/'
    click_on 'New employee...'

    fill_in first_name, with: 'Ganoes'
    fill_in last_name, with: 'Paron'
    fill_in work_percent, with: 100

    click_on 'Save'

    expect(page).to have_content('Ganoes Paron')
    expect(page).to have_content('100%')

  end

  feature 'existing' do
    before do
      FactoryGirl.create(:employee, first_name: 'Ganoes', last_name: 'Paron')
      visit '/'
      fill_in 'keywords', with: 'Paron'
      click_on 'Search'
      click_on 'Ganoes'
    end
    scenario 'edit' do
      click_on 'Edit'

      fill_in first_name, with: 'Felician'
      fill_in work_percent, with: 75

      expect(page).to have_content('Felician Paron')
      expect(page).to have_content('75%')

    end

    scenario 'delete' do
      click_on 'Felician'

      click_on 'Delete'

      expect(Employee.find_by_first_name('Felician')).to eq nil
    end
  end
end