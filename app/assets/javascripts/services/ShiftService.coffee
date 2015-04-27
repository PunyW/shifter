angular.module('shifter').factory('ShiftService', ['$resource',
  ($resource)->
    Shift = $resource('/api/work_shifts/:shiftId', {shiftId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'}
        'create': {method: 'POST'}
      }
    )

    return Shift
])