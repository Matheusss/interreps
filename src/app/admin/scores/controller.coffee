angular.module 'interreps'
 .controller 'AdminScoresController', ($rootScope, $scope, $timeout, $interval, $filter, $state, toastr, FirebaseService, reps, competitions, allCompetitionsArray) ->
    'ngInject'

    # Definitions
    $scope.reps = reps
    $scope.competitions = competitions
    $scope.allCompetitionsArray = allCompetitionsArray
    $scope.updatedReps = angular.copy $scope.reps
    $scope.selectedCompetition = {}
    $scope.selectedReps = []
    $scope.leaderboard = []

    # console.log $scope.reps

    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name

    # Methods
    $scope.methods =
      init : ->
        $scope.leaderboard = []
        $scope.selectedReps = []
        _.each $scope.reps, (rep) ->
          index = _.indexOf $scope.reps, rep
          obj =
            position: index + 1
            rep     : {}

          $scope.leaderboard.push obj

        _.map $scope.allCompetitionsArray, (competition) ->
          matches = competition.name.match(/\b(\w)/g)
          competition.initials = matches.join('')

        _.map $scope.updatedReps, (rep) ->
          _.each $scope.allCompetitionsArray, (comp) ->
           index = _.findIndex rep.competitions, (c) -> c.name is comp.name
           if index is -1
             rep.competitions.push({
               name: comp.name
               })

      validateRepsAdded : (rep) ->
        if rep
          $scope.selectedReps.push rep

      validateRepsRemoved : ($event, rep, idx) ->
        $event.stopPropagation()
        $scope.leaderboard[idx].rep = {}

        index = $scope.selectedReps.indexOf(rep)
        if index > -1
          $scope.selectedReps.splice(index, 1)

      changeSelectedCompetition : (competition) ->
        competition = JSON.parse competition
        $scope.selectedCompetition = competition

        # competition = $scope.selectedCompetition
        if competition and competition.leaderboard
          $scope.leaderboard = competition.leaderboard
        else
          $scope.methods.init()

      saveLeaderboad : (competition) ->
        competition = JSON.parse competition
        FirebaseService.updateLeaderboard(competition.name, $scope.leaderboard)
        toastr.success 'Classificação salva com sucesso'

    # Listeners & Watchers


    $scope.methods.init()
    return
