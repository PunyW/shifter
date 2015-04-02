angular.module('controllers').controller('AdminCtrl', ['$scope', '$routeParams', '$location'
  ($scope, $routeParams, $location) ->
    $scope.links = {
      employees: {
        name: 'Manage employees'
        view: 'admin/employees.html'
        path: 'employees'
      }
      shifts: {
        name: 'Manage shifts'
        view: 'admin/shifts.html'
        path: 'shifts'
        form: 'admin/shifts/show.html'
      }
    }


    $scope.changeView = (link) ->
      $scope.view = link.view
      $location.path("/admin/#{link.path}")


    resolveView = () ->
      if $routeParams.resourceId
        $scope.view = $scope.links[$routeParams.site].form
      else
        site = $routeParams.site || 'employees'
        $scope.view = $scope.links[site].view

    resolveView()
])