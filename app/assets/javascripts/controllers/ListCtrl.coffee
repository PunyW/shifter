angular.module('controllers').controller('ListCtrl', ['$scope', '$routeParams', 'ListService', 'flash', '$location',
  ($scope, $routeParams, ListService, flash, $location)->
    if $routeParams.resourceId
      if $routeParams.resourceId == 'new'
        $scope.newList = true
      else
        ListService.get({listId: $routeParams.resourceId},
          ( (list)-> $scope.list = list ),
          ( (httpResponse)->
            $scope.list = null
            flash.error = "There is no list with ID #{$routeParams.resourceId}"
            $location.path('admin/lists')
          )
        )
    else
      $location.path('/admin/lists/')

    $scope.save = () ->
      onError = (_httpResponse_)->
        $scope.errors = _httpResponse_.data
        console.log($scope.errors)
      if $scope.list.id
        $scope.list.$save(
          (()->
            $location.path('admin/lists')
            flash.success('List was updated successfully')
          ), onError
        )
      else
        ListService.create(
          $scope.list, (
            (newList) ->
              $location.path('admin/lists')
              flash.success('List was created successfully')
          ), onError
        )

    $scope.cancel = ->
      $location.path('/admin/employees/')
])