angular.module('controllers').controller('AdminCtrl', ['$scope', '$routeParams', '$location', '$rootScope',
  ($scope, $routeParams, $location, $rootScope) ->
    $scope.links = {
      employees: {
        name: 'Employees'
        view: 'admin/employees/employees.html'
        path: 'employees'
        form: 'admin/employees/form.html'
      }
      shifts: {
        name: 'Shifts'
        view: 'admin/shifts/shifts.html'
        path: 'shifts'
        form: 'admin/shifts/form.html'
      }
      lists: {
        name: 'Lists'
        view: 'admin/lists/lists.html'
        path: 'lists'
        form: 'admin/lists/form.html'
      }
    }

    $scope.menuActive = if $rootScope.menuActive == undefined then '' else $rootScope.menuActive

    $scope.changeView = (link) ->
      $scope.view = link.view
      $location.path("/admin/#{link.path}")

    $scope.toggleMenu = () ->
      $scope.menuActive = if $scope.menuActive == 'active' then '' else 'active'
      $rootScope.menuActive = $scope.menuActive

    resolveView = () ->
      if $routeParams.resourceId
        $scope.view = $scope.links[$routeParams.site].form
      else
        site = $routeParams.site || 'employees'
        $scope.view = $scope.links[site].view

    resolveView()
])