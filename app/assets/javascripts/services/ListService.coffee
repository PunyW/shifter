angular.module('shifter').factory('ListService', ['$resource',
  ($resource) ->
    List = $resource('/api/lists/:listId', {listId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'}
        'create': {method: 'POST'}
      }
    )

    return List
])