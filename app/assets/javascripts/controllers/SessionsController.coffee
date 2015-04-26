angular.module('controllers').controller('SessionsCtrl', ['$scope', '$rootScope', '$location', 'SessionService', 'AUTH_EVENTS',
  ($scope, $rootScope, $location, SessionService, AUTH_EVENTS) ->
    $scope.newSession = (credentials) ->
      SessionService.login(credentials).then ( (user) ->
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess)
      ), ->
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed)

    $scope.visible = true
    $scope.createAccount = () ->


])