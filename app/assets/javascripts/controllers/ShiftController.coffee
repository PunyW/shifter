angular.module('controllers').controller('ShiftCtrl', ['$scope', '$routeParams', '$resource', 'flash', '$location',
  ($scope, $routeParams, $resource, flash, $location) ->
    Shift = $resource('/api/work_shifts/:shiftId', {shiftId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'}
        'create': {method: 'POST'}
      }
    )

    if $routeParams.resourceId
      Shift.get({shiftId: $routeParams.resourceId},
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

    $scope.save = () ->
      onError = (_httpResponse_) ->
        error = [];
        for key, value of _httpResponse_.data
          error.push({
            name: key
            description: value
          })
        $scope.errors = error
      if $scope.shift.id
        $scope.shift.$save(
          ( ()->
            $location.path('/admin/shifts')
            flash.success = 'Shift was edited successfully'
          ), onError
        )
      else
        Shift.create($scope.shift,
          ( (newShift) -> $location.path("/admin/shifts/#{newShift.id}") ),
          onError
        )
])