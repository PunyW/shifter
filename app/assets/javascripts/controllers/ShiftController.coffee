angular.module('controllers').controller('ShiftCtrl', ['$scope', '$routeParams', '$resource', 'flash', '$location',
  ($scope, $routeParams, $resource, flash, $location) ->
    Shift = $resource('/api/work_shifts/:shiftId', { shiftId: '@id', format: 'json' },
      {
        'save': { method: 'PUT' }
        'create': { method: 'POST' }
      }
    )

    if $routeParams.resourceId
      Shift.get({ shiftId: $routeParams.resourceId },
        ( (shift)-> $scope.shift = shift ),
        ( (httpResponse)->
            $scope.shift = null
            flash.error = "There is no shift with ID #{$routeParams.resourceId}"
        )
      )
    else
      $location.path('/admin/shifts/')

    $scope.cancel = () ->
      $location.path('/admin/shifts/')
])