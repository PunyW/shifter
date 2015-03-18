angular.module('shifter').controller('ApplicationCtrl', ['$scope', '$location',
  ($scope, $location) ->
    $scope.isLoginPage = $location.path() == '/login'
])