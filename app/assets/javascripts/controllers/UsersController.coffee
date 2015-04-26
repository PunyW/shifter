angular.module('controllers').controller('UsersCtrl',['$scope', '$resource',
  ($scope, $resource)->
    User = $resource('/api/users/:userId', {userId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )

    $scope.invalid = (element, field) ->
      return element[field].$invalid && !element[field].$pristine

    $scope.user = {}
    $scope.newUser = () ->
      onError = (_httpResponse_)->
        $scope.errors = _httpResponse_.data
      User.create($scope.user,
        (() ->
          console.log('created')
        ), onError
      )
])