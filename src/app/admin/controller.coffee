angular.module 'interreps'
 .controller 'AdminController', ($rootScope, $scope, $state, $timeout, $interval, user, reps) ->
    'ngInject'

    $scope.state = $state
    $scope.user = user
    $scope.reps = reps
    $scope.img  = "../assets/images/#{$scope.user.user}.png"
    $scope.menu = [
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


    $scope.methods = {}


    return
