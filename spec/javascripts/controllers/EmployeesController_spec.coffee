describe 'EmployeesCtrl', ->
  scope = null
  ctrl = null
  location = null
  routeParams = null
  resource = null

  httpBackend = null

  employees = [
    {
      id: 1
      first_name: 'Kalam'
      last_name: 'Mekhar'
    },
    {
      id: 2
      first_name: 'Ganoes'
      last_name: 'Paron'
    }
  ]

  setupController = (results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope = $rootScope.$new()
      location = $location
      resource = $resource
      routeParams = $routeParams

      httpBackend = $httpBackend

      request = new RegExp('\/employees')
      httpBackend.expectGET(request).respond(employees)

      ctrl = $controller('EmployeesCtrl',
        $scope: scope
        $location: location)
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    beforeEach ->
      setupController()
      httpBackend.flush()

    it 'has the employees', ->
      expect(scope.employees).toEqualData(employees)