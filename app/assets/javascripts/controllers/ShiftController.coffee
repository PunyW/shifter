angular.module('controllers').controller('ShiftCtrl', ['$scope', '$routeParams', '$resource', 'flash'
  ($scope, $routeParams, $resource, flash) ->
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
      $scope.shift = {}
])