require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'has valid values and is saved to database' do
    subject { FactoryGirl.create(:employee, first_name: 'Kalam', last_name: 'Mekhar', work_percent: 100) }

    it { should be_valid }
    its(:first_name)    { should eq 'Kalam' }
    its(:last_name)     { should eq 'Mekhar' }
    its(:work_percent)  { should eq 1 }
  end

  describe 'without last name' do
    subject { Employee.create(first_name: 'Kalam', last_name: '', work_percent: 1) }

    it { should be_invalid }
  end

  describe 'with wrong work percent' do
    subject { Employee.create(first_name: 'Kalam', last_name: 'Mekhar', work_percent: 101) }

    it { should be_invalid }
  end
end
