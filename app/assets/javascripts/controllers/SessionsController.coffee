angular.module('controllers').controller('SessionsCtrl', ['$scope', 'SessionService',
  ($scope, SessionService) ->
    $scope.newSession = (authInfo) ->
      SessionService.login(authInfo)

    $scope.logout = ->
      SessionService.logout()
])