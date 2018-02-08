angular.module 'interreps'
 .controller 'AdminSchedulesController', ($rootScope, $scope, $timeout, $interval, $state, FirebaseService) ->
    'ngInject'

    $scope.events = []
    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name

    $scope.events = [
      # {title: 'All Day Event',start: new Date(y, m, 1)},
      # {title: 'Long Event',start: new Date(y, m, d - 5),end: new Date(y, m, d - 2)},
      # {id: 999,title: 'Repeating Event',start: new Date(y, m, d - 3, 16, 0),allDay: false},
      # {id: 999,title: 'Repeating Event',start: new Date(y, m, d + 4, 16, 0),allDay: false},
      # {title: 'Birthday Party',start: new Date(y, m, d + 1, 19, 0),end: new Date(y, m, d + 1, 22, 30),allDay: false},
      # {title: 'Click for Google',start: new Date(y, m, 28),end: new Date(y, m, 29),url: 'http://google.com/'}
    ]
    $scope.config =
      calendar :
        editable : yes
        header:
          left: 'month agendaWeek agendaDay',
          center: 'title',
          right: 'today prev,next'


    $scope.methods =
      addEvent : () ->
        $scope.events.push {
            # title: 'Open Sesame',
            # start: new Date(y, m, 28),
            # end: new Date(y, m, 29),
            # className: ['openSesame']
        }

    return
