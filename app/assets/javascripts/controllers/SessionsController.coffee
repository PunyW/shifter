angular.module('controllers').controller('SessionsCtrl', ['$scope', '$rootScope', 'SessionService', 'AUTH_EVENTS'
  ($scope, $rootScope, SessionService, AUTH_EVENTS) ->
    $scope.newSession = (credentials) ->
      SessionService.login(credentials).then ( (user) ->
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess)
      ), ->
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed)


    $scope.logout = ->
      SessionService.logout()
])