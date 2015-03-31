angular.module('controllers').controller('AdminCtrl', ['$scope',
  ($scope) ->
    $scope.links = [
      {
        name: 'Manage employees'
        view: 'admin/employees.html'
        controller: 'EmployeeCtrl'
      }
      {
        name: 'Manage shifts'
        view: 'admin/shifts.html'
        controller: 'ShiftCtrl'
      }
    ]

    $scope.view = $scope.links[0].view

    $scope.changeView = (link) ->
      $scope.view = link.view
])