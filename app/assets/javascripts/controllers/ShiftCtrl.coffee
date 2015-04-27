angular.module('controllers').controller('ShiftCtrl', ['$scope', '$routeParams', 'flash', '$location', 'ShiftService',
  ($scope, $routeParams, flash, $location, ShiftService) ->

    if $routeParams.resourceId
      if $routeParams.resourceId == 'new'
        $scope.newShift = true
      else
        ShiftService.get({shiftId: $routeParams.resourceId},
          ( (shift)-> $scope.shift = shift ),
          ( (httpResponse)->
            $scope.shift = null
            flash.error = "There is no shift with ID #{$routeParams.resourceId}"
            $location.path('/admin/shifts')
          )
        )
    else
      $location.path('/admin/shifts/')

    $scope.cancel = () ->
      $location.path('/admin/shifts/')


    $scope.delete = () ->
      $scope.shift.$delete()
      flash.success = 'Shift was deleted successfully'
      $location.path('/admin/shifts')

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
        ShiftService.create($scope.shift,
          ( (newShift) ->
            $location.path('/admin/shifts')
            flash.success = 'Shift was created successfully'
          ), onError
        )

    $scope.invalid = (element, field) ->
      return element[field].$invalid && !element[field].$pristine
])