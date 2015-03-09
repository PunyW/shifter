angular.module('controllers').controller('EmployeeCtrl', ['$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope, $routeParams, $resource, $location, flash)->
    Employee = $resource('/employees/:employeeId', { employeeId: '@id', format: 'json' })

    Employee.get({ employeeId: $routeParams.employeeId },
      ( (employee)-> $scope.employee = employee ),
      ( (httpResponse)->
         $scope.employee = null
         flash.error = "There is no employee with ID #{$routeParams.employeeId}"
      )
    )

    $scope.back = -> $location.path('/')
])
