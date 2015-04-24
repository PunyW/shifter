angular.module('controllers').controller('EmployeeCtrl', ['$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope, $routeParams, $resource, $location, flash)->
    Employee = $resource('/api/employees/:employeeId', {employeeId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )

    $scope.employee = {}

    if $routeParams.resourceId
      if $routeParams.resourceId == 'new'
        $scope.newShift = true
      else
        Employee.get({employeeId: $routeParams.resourceId},
          ( (employee)->
            $scope.employee = employee
            $scope.employee.work_percent *= 100
          ),
          ( (httpResponse)->
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
        console.log(_httpResponse_)
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
        Employee.create($scope.employee,
          ( (newEmployee)->
            $location.path('admin/employees')
            flash.success = 'Employee created successfully.'
          ),
          onError
        )

    $scope.delete = ->
      $scope.employee.$delete()
      $scope.cancel()

    $scope.invalid = (element, field) ->
      return element[field].$invalid && !element[field].$pristine
])
