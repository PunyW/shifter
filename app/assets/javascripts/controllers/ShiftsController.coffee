angular.module('controllers').controller('ShiftsCtrl', ['$scope', '$location', 'ShiftService',
  ($scope, $location, ShiftService) ->
    $scope.shifts = ShiftService.query()

    $scope.edit = (shiftId) ->
      $location.path("/admin/shifts/#{shiftId}")

    $scope.newShift = () ->
      $location.path('/admin/shifts/new')
])