angular.module('controllers').controller('EmployeesCtrl',
  ['$scope', '$routeParams', '$location', '$resource', 'UserService', 'EmployeeService',
    ($scope, $routeParams, $location, $resource, UserService, EmployeeService)->
      $scope.employees = EmployeeService.query()
      $scope.users = UserService.query()

      $scope.newEmployee = -> $location.path('admin/employees/new')
      $scope.edit = (employeeId)-> $location.path("admin/employees/#{employeeId}")

      $scope.popover = {
        title: 'Assign user'
        template: 'admin/employees/assignForm.html'
        autoClose: true
      }
  ])