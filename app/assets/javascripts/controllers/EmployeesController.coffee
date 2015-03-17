angular.module('controllers').controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource', 'SessionService'
  ($scope, $routeParams, $location, $resource, SessionService)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
    Employee = $resource('/api/employees/:employeeId', { employeeId: "@id", format: 'json' })

    if $routeParams.keywords
      Employee.query(keywords: $routeParams.keywords, (results)-> $scope.employees = results)
    else
      $scope.employees = Employee.query()

    $scope.view = (employeeId)-> $location.path("/employees/#{employeeId}")
    $scope.newEmployee = -> $location.path('/employees/new')
    $scope.edit = -> (employeeId)-> $location.path("/employees/#{employeeId}")

    $scope.currentUser = SessionService.currentUser()
])