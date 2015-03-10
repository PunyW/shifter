class EmployeesController < ApplicationController
  skip_before_filter :verify_authenticity_token

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

  def create
    @employee = Employee.new(params.require(:employee).permit(:first_name, :last_name, :work_percent))
    @employee.save
    render 'show', status: 201
  end

  def update
    employee = Employee.find(params[:id])
    employee.update_attributes(params.require(:employee).permit(:first_name, :last_name, :work_percent))
    head :no_content
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    head :no_content
  end
end
