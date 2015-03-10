shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

shifter.config(['$routeProvider', 'flashProvider',
  ($routeProvider, flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: 'employees/index.html'
        controller: 'EmployeesCtrl'
      ).when('/employees/new',
        templateUrl: 'employees/form.html'
        controller: 'EmployeeCtrl'
      ).when('/employees/:employeeId',
        templateUrl: 'employees/show.html'
        controller: 'EmployeeCtrl'
      ).when('/employees/:employeeId/edit',
        templateUrl: 'employees/form.html',
        controller: 'EmployeeCtrl'
      )
])

controllers = angular.module('controllers', [])