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

  describe 'create' do
    before do
      xhr :post, :create, format: :json, employee: {
          first_name: 'Kalam',
          last_name: 'Mekhar',
          work_percent: 100
        }
    end

    it { expect(response.status).to eq 201 }
    it { expect(Employee.last.first_name).to eq 'Kalam' }
    it { expect(Employee.last.last_name).to eq 'Mekhar' }
    it { expect(Employee.last.work_percent).to eq 100 }
  end

  describe 'update' do
    let(:employee) { FactoryGirl.create(:employee) }
    before do
      xhr :put, :update, format: :json, id: employee.id, employee: {
          first_name: 'Ganoes',
          last_name: 'Paron',
          work_percent: 75
        }
      employee.reload
    end

    it { expect(response.status).to eq 204 }
    it { expect(employee.first_name).to eq 'Ganoes' }
    it { expect(employee.last_name).to eq 'Paron' }
    it { expect(employee.work_percent).to eq 75 }
  end

  describe 'destroy' do
    let(:employee) { FactoryGirl.create(:employee) }
    before do
      xhr :delete, :destroy, format: :json, id: employee.id
    end

    it { expect(response.status).to eq 204 }
    it { expect(Employee.find_by_id(employee.id)).to eq nil }
  end

  def extract_name
    ->(object) { object['first_name'] }
  end
end
