angular.module('shifter').controller('ApplicationCtrl', ['$scope', '$location',
  ($scope, $location) ->
    $scope.isLoginPage = $location.path() == '/login'

    $scope.$on('$locationChangeSuccess', (event, newLoc, oldLoc) ->
      $scope.isLoginPage = newLoc.indexOf('/login') > -1
    )
])