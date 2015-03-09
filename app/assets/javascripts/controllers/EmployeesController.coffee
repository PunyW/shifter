controllers = angular.module('controllers')
controllers.controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
    Employee = $resource('/employees/:employeeId', { employeeId: "@id", format: 'json' })

    if $routeParams.keywords
      Employee.query(keywords: $routeParams.keywords, (results)-> $scope.employees = results)
    else
      $scope.employees = null
])