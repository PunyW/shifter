angular.module('controllers').controller('UsersCtrl',['$scope', '$resource', '$location',
  ($scope, $resource, $location)->
    User = $resource('/api/users/:userId', {userId: '@id', format: 'json'},
      {
        'save': {method: 'PUT'},
        'create': {method: 'POST'}
      }
    )

    $scope.invalid = (element, field) ->
      return element[field].$invalid && !element[field].$pristine

    $scope.back = () ->
      $location.path('/login')

    $scope.user = {}
    $scope.newUser = () ->
      onError = (_httpResponse_)->
        $scope.errors = _httpResponse_.data
      user = {
        user: {
          username: $scope.user.username
          email: $scope.user.email
          password: $scope.user.password
          passworc_confirmation: $scope.user.password_confirmation
        }
      }
      User.create(user,
        (() ->
          console.log('created')
        ), onError
      )
])