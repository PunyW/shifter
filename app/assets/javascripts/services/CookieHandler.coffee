angular.module('shifter').factory('CookieHandler', ['$cookieStore',
  ($cookieStore) ->
    user = null
    CookieHandler = {
      set: (user) ->
        $cookieStore.put('currentUser', user)
      get: () ->
        $cookieStore.get('currentUser')
      delete: () ->
        $cookieStore.remove('currentUser')
    }

    return CookieHandler
])