angular.module('controllers').controller('EmployeeCtrl', ['$scope', '$routeParams', '$resource', 'flash',
  ($scope, $routeParams, $resource, flash)->
    Employee = $resource('/employees/:employeeId', { employeeId: '@id', format: 'json' })

    Employee.get({ employeeId: $routeParams.employeeId },
      ( (employee)-> $scope.employee = employee ),
      ( (httpResponse)->
         $scope.employee = null
         flash.error = "There is no employee with ID #{$routeParams.employeeId}"
      )
    )
])
