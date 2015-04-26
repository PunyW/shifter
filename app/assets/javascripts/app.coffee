shifter = angular.module('shifter', [
  'templates',
  'ngRoute',
  'ngCookies',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'mgcrea.ngStrap',
  'ngAnimate',
  'validation.match'
])

shifter.config(['$routeProvider', '$httpProvider', 'flashProvider', 'USER_ROLES'
  ($routeProvider, $httpProvider, flashProvider, USER_ROLES)->
    $routeProvider
    .when('/',
      templateUrl: 'admin/index.html'
      controller: 'AdminCtrl'
      data: {
        authorizedRoles: [USER_ROLES.admin]
      }
    ).when('/login',
      templateUrl: 'sessions/login.html',
      controller: 'SessionsCtrl'
      data: {
        authorizedRoles: 'ALL'
      }
    ).when('/admin',
      templateUrl: 'admin/index.html',
      controller: 'AdminCtrl',
      data: {
        authorizedRoles: [USER_ROLES.admin]
      }
    ).when('/admin/:site',
      templateUrl: 'admin/index.html',
      controller: 'AdminCtrl'
      data: {
        authorizedRoles: [USER_ROLES.admin]
      }
    ).when('/admin/:site/:resourceId',
      templateUrl: 'admin/index.html',
      controller: 'AdminCtrl',
      data: {
        authorizedRoles: [USER_ROLES.admin]
      }
    )
    #.otherwise('/employees')

    $httpProvider.interceptors.push(['$injector',
      ($injector) ->
        return $injector.get('SessionInjector')
    ])

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

]).run(['$rootScope', '$location', 'AUTH_EVENTS', 'SessionService',
  ($rootScope, $location, AUTH_EVENTS, SessionService) ->
    $rootScope.$on('$routeChangeStart', (event, next) ->
      if next.data
        authorizedRoles = next.data.authorizedRoles
        if (!SessionService.isAuthorized(authorizedRoles))
          event.preventDefault()
          if (SessionService.currentUser())
            $rootScope.$broadcast(AUTH_EVENTS.notAuthorized)
          else
            $rootScope.$broadcast(AUTH_EVENTS.notAuthenticated)
    )
])

shifter.constant('AUTH_EVENTS', {
  loginSuccess: 'auth-login-success',
  loginFailed: 'auth-login-failed',
  logoutSuccess: 'auth-logout-success',
  sessionTimeout: 'auth-session-timeout',
  notAuthenticated: 'auth-not-authenticated',
  notAuthorized: 'auth-not-authorized'
}).constant('USER_ROLES', {
  admin: 'admin',
  normal: 'normal'
})

controllers = angular.module('controllers', [])