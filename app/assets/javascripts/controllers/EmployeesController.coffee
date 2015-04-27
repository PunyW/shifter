angular.module('controllers').controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource', 'UserService',
  ($scope, $routeParams, $location, $resource, UserService)->
    Employee = $resource('/api/employees/:employeeId', { employeeId: "@id", format: 'json' })

    $scope.employees = Employee.query()
    $scope.users = UserService.getUsers()

    $scope.newEmployee = -> $location.path('admin/employees/new')
    $scope.edit = (employeeId)-> $location.path("admin/employees/#{employeeId}")

    $scope.popover = {
      title: 'Assign user'
      template: 'admin/employees/assignForm.html'
      autoClose: true
    }
])