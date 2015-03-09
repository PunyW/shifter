angular.module('controllers').controller('EmployeeCtrl', ['$scope', '$routeParams', '$resource',
  ($scope, $routeParams, $resource)->
    Employee = $resource('/employees/:employeeId', { employeeId: '@id', format: 'json' })
])
