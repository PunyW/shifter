angular.module('shifter').factory('SessionService', ['CookieHandler', '$http', 'flash',
  (CookieHandler, $http, flash) ->
    SessionService = {
      login: (authInfo) ->
        $http.post('/api/sessions/new', authInfo)
        .success( (data) ->
          CookieHandler.set(data.user)
        ).error( (data) ->
          if data.error
            flash.error = data.error
        )
      logout: ->
        CookieHandler.delete()
    }

    return SessionService
])