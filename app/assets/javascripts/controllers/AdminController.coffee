angular.module('controllers').controller('AdminCtrl', ['$scope',
  ($scope) ->
    $scope.links = [
      {
        name: 'Manage employees'
        view: 'admin/employees.html'
      }
      {
        name: 'Manage shifts'
        view: 'admin/shifts.html'
      }
    ]

    $scope.changeView = (link) ->
      $scope.view = link.view
])