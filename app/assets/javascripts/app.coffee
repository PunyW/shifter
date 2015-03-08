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

controllers = angular.module('controllers', [])
controllers.controller('EmployeesCtrl', ['$scope',
  ($scope)->
])