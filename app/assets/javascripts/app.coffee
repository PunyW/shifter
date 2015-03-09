shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

shifter.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'EmployeesCtrl'
      ).when('/employees/:employeeId',
        templateUrl: 'show.html'
        controller: 'EmployeeCtrl'
      )
])

controllers = angular.module('controllers', [])