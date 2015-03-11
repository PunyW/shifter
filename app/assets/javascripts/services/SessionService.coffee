angular.module('shifter').factory('SessionService', ['CookieHandler', '$http', 'flash', '$location',
  (CookieHandler, $http, flash, $location) ->
    SessionService = {
      login: (authInfo) ->
        $http.post('/api/sessions/new', authInfo)
        .success( (data) ->
          CookieHandler.set(data.user)
          $location.path('/')
        ).error( (data) ->
          if data.error
            flash.error = data.error
        )
      logout: ->
        CookieHandler.delete()
    }

    return SessionService
])