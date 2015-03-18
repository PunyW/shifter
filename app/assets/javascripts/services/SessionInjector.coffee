angular.module('shifter').factory('SessionInjector', ['CookieHandler', '$rootScope', '$q', 'AUTH_EVENTS'
  (CookieHandler, $rootScope, $q, AUTH_EVENTS) ->
    return {
      request: (config) ->
        if (CookieHandler.get() != undefined )
          user = CookieHandler.get().user
          config.headers['token'] = user.token
          config.headers['username'] = user.username
        return config
      responseError: (response) ->
        $rootScope.$broadcast({
          401: AUTH_EVENTS.notAuthenticated
          403: AUTH_EVENTS.notAuthorized
          419: AUTH_EVENTS.sessionTimeout
          440: AUTH_EVENTS.sessionTimeout
        }[response.status], response)
        return $q.reject(response)
    }
])