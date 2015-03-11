describe 'CookieHandler', ->
  CookieHandler = null
  $cookieStore   = null

  beforeEach ->
    module('shifter')
    inject( (_CookieHandler_, _$cookieStore_) ->
      CookieHandler = _CookieHandler_
      $cookieStore = _$cookieStore_
    )

  it 'should assign user to currentUser', ->
     CookieHandler.set('user')
     expect($cookieStore.get('currentUser')).toBe('user')

  it 'should return current user', ->
    $cookieStore.put('currentUser', 'user')
    expect(CookieHandler.get()).toBe('user')

  it 'should remove cookie', ->
    $cookieStore.put('currentUser', 'user')
    CookieHandler.delete()
    expect($cookieStore.get('currentUser')).toBe(undefined)