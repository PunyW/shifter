require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  render_views
  describe 'index' do
    before do
      Employee.create!(first_name: 'Kalam', last_name: 'Mekhar', work_percent: 1)
      Employee.create!(first_name: 'Ben', last_name: 'Quick', work_percent: 1)
      Employee.create!(first_name: 'Ganoes', last_name: 'Paron', work_percent: 1)

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    context 'when the search finds results' do
      let(:keywords) { 'kalam' }

      it 'should 200' do
        expect(response.status).to eq 200
      end

      it 'should return one result' do
        expect(results.size).to eq 1
      end

      it "should include 'Kalam'" do
        expect(results.map(&extract_name)).to include('Kalam')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'pekka' }

      it 'should return no results' do
        expect(results.size).to eq 0
      end
    end
  end

  describe 'show' do
    before do
      xhr :get, :show, format: :json, id: employee_id
    end

    subject(:results) { JSON.parse(response.body) }

    context 'when the employee exists' do
      let(:employee) { FactoryGirl.create(:employee) }
      let(:employee_id) { employee.id }

      it { expect(response.status).to eq 200 }
      it { expect(results['id']).to eq employee.id }
      it { expect(results['first_name']).to eq employee.first_name }
      it { expect(results['last_name']).to eq employee.last_name }
    end

    context "when the employee doesn't exist" do
      let(:employee_id) { -1000 }
      it { expect(response.status).to eq(404) }
    end
  end

  def extract_name
    ->(object) { object['first_name'] }
  end
end
