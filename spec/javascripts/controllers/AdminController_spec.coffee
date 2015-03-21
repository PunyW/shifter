describe 'AdminCtrl', ->
  scope = null

  setupController = () ->
    inject(($rootScope) ->
      scope = $rootScope.$new()
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe '', ->
