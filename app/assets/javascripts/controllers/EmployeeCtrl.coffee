angular.module('controllers').controller('EmployeeCtrl',
  ['$scope', '$routeParams', '$location', 'flash', 'SessionService', 'USER_ROLES', 'EmployeeService',
    ($scope, $routeParams, $location, flash, SessionService, USER_ROLES, EmployeeService)->
      $scope.employee = {}

      if $routeParams.resourceId
        if $routeParams.resourceId == 'new'
          $scope.newShift = true
        else
          EmployeeService.get({
              employeeId: $routeParams.resourceId
            },
            ((employee) ->
              $scope.employee = employee
              $scope.employee.work_percent *= 100
            ),
            ((httpResponse)->
              $scope.employee = null
              flash.error = "There is no employee with ID #{$routeParams.resourceId}"
              $location.path('/admin/employees/')
            )
          )
      else
        $location.path('/admin/employees/')

      $scope.cancel = ->
        $location.path('/admin/employees/')

      $scope.save = ->
        onError = (_httpResponse_)->
          $scope.errors = _httpResponse_.data
          flash.error = "TODO: ERROR MESSAGE EmployeeController.coffee 33"
        if $scope.employee.id
          $scope.employee.$save(
            ( ()->
              $location.path('admin/employees')
              flash.success = 'Employee edited successfully.'
            ),
            onError
          )
        else
          EmployeeService.create($scope.employee,
            ( (newEmployee)->
              $location.path('admin/employees')
              flash.success = 'Employee created successfully.'
            ),
            onError
          )

      $scope.delete = ->
        if $scope.isAuthorized()
          $scope.employee.$delete()
          $scope.cancel()
        else
          flash.error = 'Insufficient privileges.'
          $location.path('admin/employees')

      $scope.invalid = (element, field) ->
        return element[field].$invalid && !element[field].$pristine

      $scope.isAuthorized = () ->
        SessionService.isAuthorized(USER_ROLES.admin)
  ])
