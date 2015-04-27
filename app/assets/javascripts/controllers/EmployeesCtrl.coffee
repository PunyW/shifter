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

      $scope.assignUser = (user) ->
        $scope.employee.user_id = user.id
        $scope.employee.username = user.username
        $scope.employee.$save(
          (() ->
            user.employee = $scope.employee
          ), onError
        )

      onError = (_httpResponse_) ->
        console.log(_httpResponse_)

      $scope.assignEmployee = (employee) ->
        $scope.employee = employee
  ])