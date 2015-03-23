require 'rails_helper'

RSpec.describe WorkShift, type: :model do
  describe 'has valid values and is saved to the database' do
    subject { FactoryGirl.create(:work_shift) }

    it { should be_valid }
    its(:name) { should eq 'Morning' }
    its(:description) { should eq 'Morning shift from 8 am to 4 pm' }
    its(:duration) { should eq 8.0 }
    its(:start_time) { should eq '8 am' }
    its(:end_time) { should eq '4 pm' }
  end
end
