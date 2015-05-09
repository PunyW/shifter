require 'rails_helper'

RSpec.describe ShiftWish, type: :model do
  describe 'has valid attributes and is saved to the database' do
    let(:work_shift) { FactoryGirl.create(:work_shift) }
    let(:employee) { FactoryGirl.create(:employee) }

    subject { FactoryGirl.create(:shift_wish) }

    it { should be_valid }
    its (:employee) { should eq employee }
    its (:work_shift) { should eq work_shift }
    its (:month_number) { should eq 1 }
    its (:date_number) { should eq 1 }
  end
end
