angular.module('shifter').factory('UserService', ['$resource',
  ($resource) ->
    User = $resource('/api/users/:userId', {userId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )
    UserService = {
      getUser: (id) ->

      getUsers: ()->
        return User.query()

    }

    return UserService
])