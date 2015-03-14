angular.module('controllers').controller('SessionsCtrl', ['$scope', 'SessionService',
  ($scope, SessionService) ->
    $scope.newSession = (authInfo) ->
      console.log('here')
      SessionService.login(authInfo)

    $scope.logout = ->
      SessionService.logout()
])