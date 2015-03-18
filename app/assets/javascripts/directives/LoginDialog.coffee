angular.module('shifter').directive('loginDialog', ['AUTH_EVENTS', '$location',
  (AUTH_EVENTS, $location) ->
    return {
      restrict: 'A'
      templateUrl: 'sessions/login.html'
      link: (scope) ->
        showDialog = () ->
          scope.visible = true
        hideDialog = () ->
          scope.visible = false

        scope.visible = false
        scope.$on(AUTH_EVENTS.notAuthenticated, showDialog)
        scope.$on(AUTH_EVENTS.sessionTimeout, showDialog)
        scope.$on(AUTH_EVENTS.loginSuccess, hideDialog)
        scope.$on(AUTH_EVENTS.logoutSuccess, showDialog)
    }
])