angular.module 'interreps'
 .controller 'AdminController', ($rootScope, $scope, $state, $timeout, $interval, $localStorage, StorageService, user, reps) ->
    'ngInject'

    $scope.state = $state
    $scope.$storage = $localStorage
    $scope.user = user
    $scope.reps = reps
    $scope.status =
     isopen: no
    $scope.logout =
     isopen: no
    $scope.img  = "../assets/images/#{$scope.user.user}.png"
    $rootScope.menu = [
      {
        name: 'Repúblicas'
        icon: 'fas fa-users fa-lg'
        state: 'admin.reps'
      }
      {
        name: 'Horários'
        icon: 'fas fa-clock fa-lg'
        state: 'admin.schedules'
      }
      {
        name: 'Placar'
        icon: 'fas fa-trophy fa-lg'
        state: 'admin.scores'
      }
      {
        name: 'Regulamento'
        icon: 'fas fa-exclamation-circle fa-lg'
        state: 'admin.rules'
      }
    ]

    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $scope.state.current.name

    $scope.methods =
      logout : () ->
        StorageService.deleteCurrentUser()
        $state.go 'home', {logout: yes}

    return
