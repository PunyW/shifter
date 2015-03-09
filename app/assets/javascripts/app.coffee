shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers'
])

shifter.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'EmployeesCtrl'
    )
])

employees = [
  {
    id: 1
    first_name: 'Kalam'
    last_name: 'Mekhar'
  },
  {
    id: 2
    first_name: 'Ben Adaephon'
    last_name: 'Delat'
  },
  {
    id: 3
    first_name: 'Ganoes'
    last_name: 'Paron'
  }
]

controllers = angular.module('controllers', [])
controllers.controller('EmployeesCtrl', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
    Employee = $resource('/employees/:employeeId', { employeeId: "@id", format: 'json' })

    if $routeParams.keywords
      Employee.query(keywords: $routeParams.keywords, (results)-> $scope.employees = results)
    else
      $scope.employees = null
])