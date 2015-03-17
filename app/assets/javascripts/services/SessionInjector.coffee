angular.module('shifter').factory('SessionInjector', ['CookieHandler',
  (CookieHandler) ->
    return {
      request: (config) ->
        if (CookieHandler.get() != undefined )
          user = CookieHandler.get().user
          config.headers['token'] = user.token
          config.headers['username'] = user.username
        return config
    }
])