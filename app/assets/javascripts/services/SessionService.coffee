angular.module('shifter').factory('SessionService', ['CookieHandler', '$http', 'flash', '$location',
  (CookieHandler, $http, flash, $location) ->
    SessionService = {
      login: (authInfo) ->
        $http.post('/api/sessions/new', authInfo)
        .success( (user) ->
          CookieHandler.set(user)
          $location.path('/')
        ).error( (data) ->
          CookieHandler.delete()
          if data.error
            flash.error = data.error
        )
      logout: ->
        CookieHandler.delete()
      currentUser: ->
        CookieHandler.get()
    }

    return SessionService
])