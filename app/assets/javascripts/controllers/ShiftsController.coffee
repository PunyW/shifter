angular.module('controllers').controller('ShiftsCtrl', ['$scope', '$location', '$resource',
  ($scope, $location, $resource) ->
    Shift = $resource('/api/work_shifts/:shiftId', { shiftId: "@id", format: 'json' })
    $scope.shifts = Shift.query()

    $scope.edit = (shiftId) ->
      $location.path("/admin/shifts/#{shiftId}")

    $scope.newShift = () ->
      $location.path('/admin/shifts/new')
])