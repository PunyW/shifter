require 'rails_helper'

include TestUtils

feature 'Employee', js: true do
  describe 'When logged in' do
    let!(:user) { FactoryGirl.create(:user) }
    before :each do
      sign_in_capybara({ email: user.email, password: 'Admin123'})
    end

    feature 'form' do
      before do
        visit '/'
        click_on 'New employee...'
      end

      scenario 'invalid parameters' do
        fill_in 'first_name', with: ' '
        fill_in 'last_name', with: ' '
        fill_in 'work_percent', with: '101'

        expect(page).to have_content('First name is required')
        expect(page).to have_content('Last name is required')
        expect(page).to have_content('Enter number between 0 and 100')

        click_on 'Cancel'
        expect(page).to have_content('New employee...')
      end
    end

    feature 'new' do
      before do
        visit '/'
        click_on 'New employee...'
      end
      scenario 'create with valid parameters' do
        fill_in 'first_name', with: 'Ganoes'
        fill_in 'last_name', with: 'Paron'
        fill_in 'work_percent', with: 100

        click_on 'Save'

        expect(page).to have_content('Ganoes Paron')
        expect(page).to have_content('100%')
      end
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

        fill_in 'first_name', with: 'Felician'
        fill_in 'work_percent', with: 75

        click_on 'Save'

        expect(page).to have_content('Felician Paron')
        expect(page).to have_content('75%')

      end

      scenario 'delete' do
        click_on 'Delete'

        expect(Employee.find_by_last_name('Paron')).to eq nil
      end
    end
  end
end