require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'has valid attributes and is saved to database' do
    subject { FactoryGirl.create(:list, length: 3, number: 1, start_date: '2015-04-27', end_date: '2015-05-11') }

    it { should be_valid }
    its (:length)     { should eq 3 }
    its (:number)     { should eq 1 }
    its (:start_date) { should eq Date.parse('2015-04-27') }
    its (:end_date)   { should eq Date.parse('2015-05-11') }
  end

  describe 'with invalid values is not saved to database' do
    subject { List.create(length: ' ', number: ' ', start_date: ' ', end_date: ' ')}

    it { should be_invalid }
  end
end
