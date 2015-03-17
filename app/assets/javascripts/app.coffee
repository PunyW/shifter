shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
  'ngCookies',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

shifter.config(['$routeProvider', '$httpProvider', 'flashProvider',
  ($routeProvider, $httpProvider, flashProvider)->
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
      ).when('/login',
        templateUrl: 'sessions/login.html',
        controller: 'SessionsCtrl'
      )

    $httpProvider.interceptors.push('SessionInjector')

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")
])

shifter.constant('AUTH_EVENTS', {
  loginSuccess: 'auth-login-success',
  loginFailed: 'auth-login-failed',
  logoutSuccess: 'auth-logout-success',
  sessionTimeout: 'auth-session-timeout',
  notAuthenticated: 'auth-not-authenticated',
  notAuthorized: 'auth-not-authorized'
}).constant('USER_ROLERS', {
  admin: 'admin',
  normal: 'normal'
})



controllers = angular.module('controllers', [])