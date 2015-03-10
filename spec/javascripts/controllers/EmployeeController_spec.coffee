describe 'EmployeeCtrl', ->
  scope       = null
  ctrl        = null
  routeParams = null
  httpBackend = null
  location    = null
  flash       = null
  employeeId  = 87

  fakeEmployee =
    id: employeeId
    first_name: 'Kalam'
    last_name: 'Mekhar'
    work_percent: 1

  setupController = (employeeExists = true, employeeId = 87)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      flash       = _flash_
      routeParams.employeeId = employeeId if employeeId

      if employeeId
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

    describe 'create', ->
      newEmployee =
        id: 87
        first_name: 'Kalam'
        last_name: 'Mekhar'
        work_percent: 100

      beforeEach ->
        setupController(false, false)
        request = new RegExp("\/employees")
        httpBackend.expectPOST(request).respond(201, newEmployee)

      it 'posts to the backend', ->
        scope.employee.first_name = newEmployee.first_name
        scope.employee.last_name = newEmployee.last_name
        scope.employee.work_percent = newEmployee.work_percent
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/employees/#{newEmployee.id}")

    describe 'update', ->
      updateEmployee =
        first_name: 'Ganoes'
        last_name: 'Paron'
        work_percent: 75

      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp('\/employees')
        httpBackend.expectPUT(request).respond(204)

      it 'posts to the backend', ->
        scope.employee.first_name = updateEmployee.first_name
        scope.employee.last_name = updateEmployee.last_name
        scope.employee.work_percent = updateEmployee.work_percent
        scope.save()
        httpBackend.flush()
        expect(location.path()).toBe("/employees/#{scope.employee.id}")

    describe 'delete', ->
      beforeEach ->
        setupController()
        httpBackend.flush()
        request = new RegExp("\/employees/#{scope.employee.id}")
        httpBackend.expectDELETE(request).respond(204)

      it 'posts to the backend', ->
        scope.delete()
        httpBackend.flush()
        expect(location.path()).toBe('/')
