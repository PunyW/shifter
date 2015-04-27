angular.module('shifter').directive('shifterCalendar', [
  () ->
    return {
      restrict: 'E'
      templateUrl: 'calendar/calendar.html'
      controller: 'ShiftCalCtrl'
      link: ->
    }
])