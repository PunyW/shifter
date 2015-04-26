class EmployeesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_employee, only: [:show, :update, :destroy]
  before_action :signed_in?
  before_action :admin_only, except: [:index, :show, :update]

  def index
    @employees = if params[:keywords]
                   Employee.where('first_name ilike ? or last_name ilike ?', "%#{params[:keywords]}%", "%#{params[:keywords]}%")
                 else
                   Employee.all
                 end
  end

  def show
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render 'show', status: 201
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update_attributes(employee_params)
      head :no_content
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :work_percent)
    end
end
