angular.module('shifter').factory('ShiftWishService', ['$resource',
  ($resource) ->
    $resource('/api/shift_wish/:wishId', { wishId: '@id', format: 'json' },
      {
        'save': {method: 'PUT'}
        'create': {method: 'POST'}
      }
    )
])