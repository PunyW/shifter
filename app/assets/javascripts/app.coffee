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