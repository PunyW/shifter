describe 'ShiftCtrl', ->
  scope       = null
  routeParams = null
  ctrl        = null
  httpBackend = null
  flash       = null
  shiftId     = 12

  fakeShift   =
    id: shiftId
    name: 'Morning'
    description: 'Morning'
    duration: 8
    start_time: '7 am'
    end_time: '15 pm'

  setupController = (shiftExists = true, shiftId = fakeShift.id)->
    inject(($routeParams, $rootScope, $controller, $httpBackend, _flash_)->
      scope = $rootScope.$new()
      routeParams = $routeParams
      httpBackend = $httpBackend
      flash = _flash_
      routeParams.resourceId = shiftId if shiftId

      if shiftId
        request = new RegExp("\work_shifts/#{shiftId}")
        results = if shiftExists
          [200, fakeShift]
        else
          [404]

        httpBackend.expectGET(request).respond(results[0], results[1])

      ctrl = $controller('ShiftCtrl', $scope: scope)
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller init', ->
    describe 'shift is found', ->
      beforeEach(setupController())
      it 'loads the given shift', ->
        httpBackend.flush()
        expect(scope.shift).toEqualData(fakeShift)

    describe 'shift is not found', ->
      beforeEach(setupController(false))
      it 'tries to load the given shift', ->
        httpBackend.flush()
        expect(scope.shift).toBe(null)
        expect(flash.error).toBe("There is no shift with ID #{fakeShift.id}")