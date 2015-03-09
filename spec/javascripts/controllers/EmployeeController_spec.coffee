describe 'EmployeeCtrl', ->
  scope       = null
  ctrl        = null
  routeParams = null
  httpBackend = null
  flash       = null
  employeeId  = 87

  fakeEmployee =
    id: employeeId
    first_name: 'Kalam'
    last_name: 'Mekhar'
    work_percent: 1

  setupController = (employeeExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      flash       = _flash_
      routeParams.employeeId = employeeId

      request = new RegExp("\/employees/#{employeeId}")
      results = if employeeExists
        [200, fakeEmployee]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0], results[1])

      ctrl        = $controller('EmployeeCtrl', $scope: scope)
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'employee is found', ->
      beforeEach(setupController())
      it 'loads the given employee', ->
        httpBackend.flush()
        expect(scope.employee).toEqualData(fakeEmployee)

    describe 'employee is not found', ->
      beforeEach(setupController(false))
      it 'loads the given employee', ->
        httpBackend.flush()
        expect(scope.employee).toBe(null)
        expect(flash.error).toBe("There is no employee with ID #{employeeId}")