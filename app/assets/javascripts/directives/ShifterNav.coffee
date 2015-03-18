angular.module('shifter').directive('shifterNav', ['SessionService',
  (SessionService) ->
    return {
      restrict: 'A'
      templateUrl: 'navbar.html'
      link: (scope) ->
        scope.links = [
          {
            route: '/?(navbar)?'
            link: '/#/'
            text: 'Home'
          },
          {
            route: '/employees'
            link: '/#/employees'
            text: 'Employees'
          }
        ]

        scope.currentUser = SessionService.currentUser()
        scope.logout = () ->
          SessionService.logout()
    }
])