angular.module('shifter').factory('EmployeeService', ['$resource',
  ($resource)->
    Employee = $resource('/api/employees/:employeeId', {employeeId: "@id", format: 'json'},
      {
        'save': {method: 'PUT'}
        'create': {method: 'POST'}
      }
    )

    return Employee
])