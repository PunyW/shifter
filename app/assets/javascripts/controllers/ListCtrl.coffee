angular.module('controllers').controller('ListCtrl', ['$scope', '$routeParams', 'ListService', 'flash',
  ($scope, $routeParams, ListService, flash)->
    if $routeParams.resourceId
      if $routeParams.resourceId == 'new'
        $scope.newList = true
      else
        ListService.get({listId: $routeParams.resourceId},
          ( (list)-> $scope.list = list ),
          ( (httpResponse)->
            $scope.list = null
            flash.error = "There is no list with ID #{$routeParams.resourceId}"
            $location.path('/admin/lists')
          )
        )
    else
      $location.path('/admin/lists/')
])