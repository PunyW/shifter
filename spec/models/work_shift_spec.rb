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

  describe 'with invalid name' do
    subject { WorkShift.create(name: '', description: 'Dummy text for testing purposes', duration: 8.0, start_time: '4 am', end_time: '8 pm') }
    it { should be_invalid }
  end

  describe 'with invalid description' do
    subject { WorkShift.create(name: 'Dummy', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec mauris hendrerit, malesuada sapien sollicitudin, cursus turpis. Proin volutpat eget arcu non ornare. Curabitur rutrum augue sit nullam.', duration: 8.0, start_time: '4 am', end_time: '8 pm') }
    it { should be_invalid }
  end

  describe 'with invalid duration' do
    subject { WorkShift.create(name: 'dummy', description: 'Dummy text for testing purposes', duration: 0, start_time: '4 am', end_time: '8 pm') }
    it { should be_invalid }
  end

  describe 'with invalid start time' do
    subject { WorkShift.create(name: 'dummy', description: 'Dummy text for testing purposes', duration: 8.0, start_time: ' ', end_time: '8 pm') }
    it { should be_invalid }
  end

  describe 'with invalid end time' do
    subject { WorkShift.create(name: 'dummy', description: 'Dummy text for testing purposes', duration: 8.0, start_time: '4 am', end_time: ' ') }
    it { should be_invalid }
  end
end
