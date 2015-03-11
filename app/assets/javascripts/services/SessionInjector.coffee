angular.module('shifter').factory('SessionInjector', ['CookieHandler',
  (CookieHandler) ->
    return {
      request: (config) ->
        if (CookieHandler.get() != undefined )
          config.headers['token'] = CookieHandler.get().token
          config.headers['username'] = CookieHandler.get().username

        return config
    }
])