angular.module('controllers').controller('ListsCtrl', ['$scope', '$location',
  ($scope, $location) ->

    $scope.newList = ->
      $location.path('admin/lists/new')
])