describe 'EmployeesCtrl', ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null

  httpBackend = null

  employees = [
    {
      id: 1
      first_name: 'Kalam'
      last_name: 'Mekhar'
    }
  ]

  setupController = (keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams

      routeParams.keywords = keywords

      httpBackend = $httpBackend

      if results
        request = new RegExp("\/employees.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)
      else
        request = new RegExp('\/employees')
        httpBackend.expectGET(request).respond(employees)

      ctrl        = $controller('EmployeesCtrl',
        $scope:scope
        $location: location)
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach ->
        setupController()
        httpBackend.flush()

      it 'is empty by default', ->
        expect(scope.employees).toEqualData(employees)

    describe 'with keywords', ->
      keywords = 'kalam'

      employees = [
        {
          id: 1
          first_name: 'Kalam'
          last_name: 'Mekhar'
        }
      ]

      beforeEach ->
        setupController(keywords, employees)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.employees).toEqualData(employees)

    describe 'search()', ->
      beforeEach ->
        setupController()
        httpBackend.flush()

      it 'redirects to itself with a keyword param', ->
        keywords = 'foo'
        scope.search(keywords)
        expect(location.path()).toBe('/')
        expect(location.search()).toEqualData({keywords: keywords})