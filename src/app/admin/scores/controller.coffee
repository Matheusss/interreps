angular.module 'interreps'
 .controller 'AdminScoresController', ($rootScope, $scope, $timeout, $interval, $filter, $state, FirebaseService, reps, competitions, allCompetitionsArray) ->
    'ngInject'

    # Definitions
    $scope.reps = reps
    $scope.competitions = competitions
    $scope.allCompetitionsArray = allCompetitionsArray
    $scope.selectedReps = []
    $scope.leaderboard = []

    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name

    _.each $scope.reps, (rep) ->
      index = _.indexOf $scope.reps, rep
      obj = {
        position: index + 1
        rep     : ''
      }
      $scope.leaderboard.push obj

    # Methods
    $scope.methods =
      validateRepsAdded : (rep) ->
        if rep
          $scope.selectedReps.push rep

      validateRepsRemoved : ($event, rep, idx) ->
        $event.stopPropagation()
        $scope.leaderboard[idx].rep = undefined

        index = $scope.selectedReps.indexOf(rep)
        if index > -1
          $scope.selectedReps.splice(index, 1)

    return
