angular.module('controllers').controller('EmployeeCtrl', ['$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope, $routeParams, $resource, $location, flash)->
    Employee = $resource('/api/employees/:employeeId', { employeeId: '@id', format: 'json' },
      {
        'save':   {method: 'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.employeeId
      Employee.get({ employeeId: $routeParams.employeeId },
        ( (employee)-> $scope.employee = employee ),
        ( (httpResponse)->
           $scope.employee = null
           flash.error = "There is no employee with ID #{$routeParams.employeeId}"
        )
      )
    else
      $scope.employee = {}

    $scope.back = -> $location.path('/')
    $scope.edit = -> $location.path("/employees/#{$scope.employee.id}/edit")
    $scope.cancel = ->
      if $scope.employee.id
        $location.path("/employees/#{$scope.employee.id}")
      else
        $location.path('/')

    $scope.save = ->
      onError = (_httpResponse_)->
        $scope.errors = _httpResponse_.data
        flash.error = "Something went wrong"
      if $scope.employee.id
        $scope.employee.$save(
          ( ()-> $location.path("/employees/#{$scope.employee.id}") ),
          onError
        )
      else
        Employee.create($scope.employee,
          ( (newEmployee)-> $location.path("/employees/#{newEmployee.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.employee.$delete()
      $scope.back()
])
