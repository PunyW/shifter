angular.module('controllers').controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/employees').search('keywords', keywords)
    Employee = $resource('/api/employees/:employeeId', { employeeId: "@id", format: 'json' })

    if $routeParams.keywords
      Employee.query(keywords: $routeParams.keywords, (results)-> $scope.employees = results)
    else
      $scope.employees = Employee.query()

    $scope.newEmployee = -> $location.path('/employees/new')
    $scope.edit = (employeeId)-> $location.path("/employees/#{employeeId}")
])