require 'rails_helper'
include TestUtils

feature 'AdminPanel', js: true do
  describe 'shifts' do
    let!(:user) { FactoryGirl.create(:user)}
    before :each do
      FactoryGirl.create(:work_shift)
      sign_in_capybara({ email: user.email, password: 'Admin123' })
      visit '/#/admin'
      click_on 'Shifts'
    end

    feature 'landing page' do
      scenario 'list' do
        expect(page).to have_content 'Morning'
      end

      scenario 'create new shift' do
        click_on 'Create new...'
        fill_in 'name', with: 'Morning'
        fill_in 'description', with: 'Morning shift'
        fill_in 'startTime', with: '07:00'
        fill_in 'endTime', with: '14:00'
        fill_in 'duration', with: 8
        fill_in 'abbreviation', with: 'A'
        click_on 'Save'

        expect(WorkShift.last.name).to eq 'Morning'
      end

      scenario 'new shift with invalid values' do
        click_on 'Create new...'

        fill_in 'name', with: ' '
        fill_in 'description', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec mauris hendrerit, malesuada sapien sollicitudin, cursus turpis. Proin volutpat eget arcu non ornare. Curabitur rutrum augue sit nullam.'
        fill_in 'startTime', with: ' '
        fill_in 'endTime', with: ' '
        fill_in 'duration', with: ' '
        fill_in 'abbreviation', with: 'Wrong'

        expect(page).to have_content 'Name cannot be blank.'
        expect(page).to have_content 'Description cannot be over 200 characters long.'
        expect(page).to have_content 'Start time cannot be blank.'
        expect(page).to have_content 'End time cannot be blank.'
        expect(page).to have_content 'Duration cannot be blank.'
        expect(page).to have_content 'Abbreviation has to be between 1 and 3 letters long.'
      end

      scenario 'editing shift' do
        click_on 'Morning'

        expect(page).to have_content 'Shift name'
        fill_in 'name', with: 'Night'
        click_on 'Save'

        expect(page).to have_content 'Night'
        expect(page).to have_content 'Shift was edited successfully'
      end

      scenario 'deleting shift' do
        click_on 'Morning'
        click_on 'Delete'

        expect(page).to have_no_content 'Morning'
        expect(page).to have_content 'Shift was deleted successfully'
        expect(WorkShift.all.length).to eq 0
      end
    end
  end
end