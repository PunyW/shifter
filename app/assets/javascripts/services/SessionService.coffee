angular.module('shifter').factory('SessionService', ['CookieHandler', '$http', 'flash', '$location',
  (CookieHandler, $http, flash, $location) ->
    SessionService = {
      login: (credentials) ->
        $http.post('/api/sessions/new', credentials)
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
        if CookieHandler.get()
          CookieHandler.get().user
      isAuthorized: (authorizedRoles) ->
        if authorizedRoles == 'ALL'
          return true
        if !angular.isArray(authorizedRoles)
          authorizedRoles = [authorizedRoles]
        return SessionService.currentUser() && authorizedRoles.indexOf(CookieHandler.get().user.user_role) != -1
    }

    return SessionService
])