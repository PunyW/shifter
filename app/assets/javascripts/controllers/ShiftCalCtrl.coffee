angular.module('controllers').controller('ShiftCalCtrl',
  ['$scope', 'EmployeeService', 'ShiftService', 'ShiftWishService', 'ListService',
    ($scope, EmployeeService, ShiftService, ShiftWishService, ListService) ->
      divided = false
      small = false

      activeList = 2
      lastList = 2
      firstList = 1

      ListService.query().$promise.then((lists) ->
        $scope.lists = lists
        lastList = lists.length
        $scope.currentList = getCurrentList()
        $scope.selected = _removeTime(moment($scope.currentList.start_date))
        _checkWindowWidth();
        _buildList($scope, $scope.selected.clone());
        setShifts()
      )

      $scope.wishes = {}
      ShiftWishService.query().$promise.then((wishes) ->
        for key, wish of wishes
          if wish.employee
            if $scope.wishes[wish.employee.id]
              if $scope.wishes[wish.employee.id][wish.month_number]
                $scope.wishes[wish.employee.id][wish.month_number][wish.date_number] = wish.work_shift.short_name || wish.work_shift.name.charAt(0).toUpperCase()
              else
                $scope.wishes[wish.employee.id][wish.month_number] = {}
                $scope.wishes[wish.employee.id][wish.month_number][wish.date_number] = wish.work_shift.short_name || wish.work_shift.name.charAt(0).toUpperCase()
            else
              $scope.wishes[wish.employee.id] = {}
              $scope.wishes[wish.employee.id][wish.month_number] = {}
              $scope.wishes[wish.employee.id][wish.month_number][wish.date_number] = wish.work_shift.short_name || wish.work_shift.name.charAt(0).toUpperCase()
      )

      $scope.shifts = []
      setShifts = ->
        ShiftService.query().$promise.then((result) ->
          for key, shift of result
            if shift.name
              $scope.shifts.push({
                text: shift.name
                click: "setShift(\"#{shift.short_name}\", \"#{shift.id}\", \"#{shift.name}\")"
              })
        )

      $scope.setShift = (short_name, id, name)->
        if short_name == 'null'
          $scope.wishes[$scope.employee.id][$scope.day.month][$scope.day.number] = name.charAt(0).toUpperCase()
        else
          $scope.wishes[$scope.employee.id][$scope.day.month][$scope.day.number] = short_name
        ShiftWishService.create({
            employee_id: $scope.employee.id
            date_number: $scope.day.number
            month_number: $scope.day.month
            work_shift_id: id
          }, ( (newWish) ->
            # TODO: Success
          ), (httpResponse) ->
            # TODO: ERROR
        )


      $scope.setInformation = (employee, day) ->
        $scope.employee = employee
        $scope.day = day

      $scope.getWish = (employee, day) ->
        if $scope.wishes[employee.id]
          if $scope.wishes[employee.id][day.month]
            $scope.wishes[employee.id][day.month][day.number] || 'V'
          else
            $scope.wishes[employee.id][day.month] = {}
            $scope.wishes[employee.id][day.month][day.number] = {}
            'V'
        else
          $scope.wishes[employee.id] = {}
          $scope.wishes[employee.id][day.month] = {}
          $scope.wishes[employee.id][day.month][day.number] = {}
          'V'


      $scope.listWidth = '960pt'
      $scope.part = false
      $scope.employees = EmployeeService.query()

      _removeTime = (date)->
        if (date.day() == 0)
          date.day(-6).hour(0).minute(0).second(0).millisecond(0)
        else
          date.day(1).hour(0).minute(0).second(0).millisecond(0)

      _getWidth = ->
        if divided && !small
          95 / _partLength()
        else if small
          return 95
        else
          return 95 / 3

      getCurrentList = ->
        i = 0
        while i < $scope.lists.length
          if $scope.lists[i]['number'] == activeList
            return $scope.lists[i]
          i++
        return false

      $scope.width = _getWidth() + '%'

      _updateList = (listWidth, isDivided, isSmall, part) ->
        if typeof part == "undefined"
          $scope.part = false
        else
          $scope.part = part

        divided = isDivided
        small = isSmall
        $scope.listWidth = listWidth
        $scope.width = _getWidth() + '%'
        _buildList($scope, $scope.selected.clone())

      _buildList = (scope, start)->
        if divided
          if small
            $scope.length = 1
          else
            $scope.length = _partLength()
        else
          $scope.length = 3

        scope.list = []
        date = start.clone()
        i = 0
        while i < $scope.length
          scope.list.push days: _buildWeek(date.clone())
          date.add 1, 'w'
          i++

      _buildWeek = (date) ->
        days = []
        i = 0
        while i < 7
          days.push
            name: date.format('dd').substring(0, 1)
            number: date.date()
            month: date.get('month') + 1
            date: date
            shift: 'V'
          date = date.clone()
          date.add 1, 'd'
          i++

        return days

      _partLength = ->
        if small
          return 1

        if 3 % 2 == 0
          return 3 / 2
        else
          return 3

      $scope.getLength = ->
        new Array($scope.length)

      $scope.lastList = ->
        $scope.currentList.number == lastList

      $scope.firstList = ->
        $scope.currentList.number == firstList

      $scope.next = ->
        if $scope.lastList()
          return
        activeList++;
        $scope.currentList = getCurrentList()

        if divided && 3 != 1
          _nextPart()
        else
          _next()

      _next = ->
        $scope.selected.add(7 * 3, 'days')
        start = $scope.selected.clone()
        _buildList($scope, start)

      _nextPart = ->
        days = _partLength() * 7
        if small && $scope.part < 3
          days *= $scope.part++
        else if $scope.part == 1
          $scope.part++
        else
          $scope.part = 1
          $scope.width = _getWidth() + '%'
          _next()
          return

        $scope.width = _getWidth() + '%'
        start = $scope.selected.clone().add(days, 'days')
        _buildList($scope, start)

      $scope.previous = ->
        if $scope.firstList()
          return
        activeList--
        $scope.currentList = getCurrentList()
        if small
          _previousPartSmall()
        else if divided
          _previousPart()
        else
          _previous()

      _previous = (days) ->
        $scope.selected.subtract(7 * 3, 'days')

        if days
          start = $scope.selected.clone().add(days, 'days')
        else
          start = $scope.selected.clone()

        _buildList($scope, start)

      _previousPart = ->
        days = 3 * 7

        if $scope.part > 1
          $scope.part--
        else
          $scope.part = 2
          $scope.width = _getWidth() + '%'
          _previous(days)
          return

        $scope.width = _getWidth() + '%'
        _buildList($scope, $scope.selected.clone())

      _previousPartSmall = ->
        if $scope.part > 1
          $scope.part--
          days = $scope.part * 7 - 7
          _buildList($scope, $scope.selected.clone().add(days, 'days'))
        else
          $scope.part = 3
          _previous((3 - 1) * 7)

      $(window).on('resize.doResize', ->
        $scope.$apply(->
          _checkWindowWidth()
        )
      )

      $scope.$on('$destroy', ->
        $(window).off('resize.doResize')
      )

      _checkWindowWidth = ->
        innerWidth = (window.innerWidth - 25) + 'pt'
        if (window.innerWidth < 740)
          _updateList(innerWidth, true, true, 1)
        else if window.innerWidth < 840
          _updateList(innerWidth, true, false, 1)
        else if window.innerWidth < 965
          _updateList(innerWidth, false, false)
        else
          _updateList('965pt', false, false)
  ])