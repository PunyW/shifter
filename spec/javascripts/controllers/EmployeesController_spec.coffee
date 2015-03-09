describe 'EmployeesCtrl', ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null

  setupController = (keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams

      routeParams.keywords = keywords

      ctrl        = $controller('EmployeesCtrl',
        $scope:scope
        $location: location)
    )

  beforeEach(module('shifter'))
  beforeEach(setupController())

  it 'shows all employees by default', ->
    expect(scope.employees).toEqualData([{ id : 1, first_name : 'Kalam', last_name : 'Mekhar' }, { id : 2, first_name : 'Ben Adaephon', last_name : 'Delat' }, { id : 3, first_name : 'Ganoes', last_name : 'Paron' }])