angular.module('shifter').directive('loginDialog', ['AUTH_EVENTS',
  (AUTH_EVENTS) ->
    return {
      restrict: 'A'
      templateUrl: 'sessions/login.html'
      link: (scope) ->
        showDialog = () ->
          scope.visible = true

        scope.visible = false
        scope.$on(AUTH_EVENTS.notAuthenticated, showDialog)
        scope.$on(AUTH_EVENTS.sessionTimeout, showDialog)
    }
])