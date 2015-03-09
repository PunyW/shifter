class EmployeesController < ApplicationController
  def index
    @employees = if params[:keywords]
                   Employee.where('first_name ilike ? or last_name ilike ?', "%#{params[:keywords]}%", "%#{params[:keywords]}%")
                 else
                   []
                 end
  end

  def show
    @employee = Employee.find(params[:id])
  end
end
