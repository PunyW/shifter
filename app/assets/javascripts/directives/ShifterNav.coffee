angular.module('shifter').directive('shifterNav', ['SessionService', 'AUTH_EVENTS'
  (SessionService, AUTH_EVENTS) ->
    return {
      restrict: 'A'
      templateUrl: 'navbar.html'
      link: (scope) ->
        scope.links = [
          {
            route: '/?(navbar)?'
            link: '/#/'
            text: 'Home'
          },
          {
            route: '/employees'
            link: '/#/'
            text: 'Employees'
          }
        ]

        checkUser = () ->
          scope.currentUser = SessionService.currentUser()

        scope.currentUser = SessionService.currentUser()
        scope.logout = () ->
          SessionService.logout()

        scope.$on(AUTH_EVENTS.notAuthenticated, checkUser)
        scope.$on(AUTH_EVENTS.sessionTimeout, checkUser)
        scope.$on(AUTH_EVENTS.loginSuccess, checkUser)
        scope.$on(AUTH_EVENTS.logoutSuccess, checkUser)
    }
])