describe 'EmployeeCtrl', ->
  scope       = null
  ctrl        = null
  routeParams = null
  httpBackend = null
  employeeId  = 87

  fakeEmployee =
    id: employeeId
    first_name: 'Kalam'
    last_name: 'Mekhar'
    work_percent: 1

  setupController = (employeeExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.employeeId = employeeId

      ctrl        = $controller('EmployeeCtrl', $scope: scope)
    )

  beforeEach(module('shifter'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
