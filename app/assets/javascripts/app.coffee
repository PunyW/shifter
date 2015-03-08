shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
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
controllers.controller('EmployeesCtrl', ['$scope', '$routeParams', '$location',
  ($scope, $routeParams, $location)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.employees = employees.filter (employee)-> employee.first_name.toLowerCase().indexOf(keywords) != -1 ||
        employee.last_name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.employees = employees
])