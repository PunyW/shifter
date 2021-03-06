angular.module('shifter').directive('shifterNav', ['SessionService', 'AUTH_EVENTS', 'USER_ROLES',
  (SessionService, AUTH_EVENTS, USER_ROLES) ->
    return {
      restrict: 'A'
      templateUrl: 'navbar.html'
      link: (scope) ->
        scope.links = [
          {
            route: 'calendar'
            link: '/#/'
            text: 'Calendar'
          }
        ]

        checkUser = () ->
          scope.currentUser = SessionService.currentUser()

        scope.currentUser = SessionService.currentUser()
        scope.admin = () ->
          if scope.currentUser
            return SessionService.currentUser().user_role == USER_ROLES.admin
          else
            false
        scope.logout = () ->
          SessionService.logout()

        scope.$on(AUTH_EVENTS.notAuthenticated, checkUser)
        scope.$on(AUTH_EVENTS.sessionTimeout, checkUser)
        scope.$on(AUTH_EVENTS.loginSuccess, checkUser)
        scope.$on(AUTH_EVENTS.logoutSuccess, checkUser)
    }
])