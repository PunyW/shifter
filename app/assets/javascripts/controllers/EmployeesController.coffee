angular.module('controllers').controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    Employee = $resource('/api/employees/:employeeId', { employeeId: "@id", format: 'json' })

    $scope.employees = Employee.query()

    $scope.newEmployee = -> $location.path('admin/employees/new')
    $scope.edit = (employeeId)-> $location.path("admin/employees/#{employeeId}")
])