angular.module 'interreps'
 .controller 'RegisterController', ($rootScope, $scope, $timeout, $interval, $localStorage, FirebaseService, rep, competitions) ->
    'ngInject'

    $scope.rep = rep
    $scope.allCompetitions = competitions
    $scope.img = "../assets/images/#{$scope.rep.user}.jpg"
    $scope.selectedCompetitions = $scope.rep.competitions or []
    $scope.user         = $localStorage.user
    $scope.participant  = ''
    $scope.participants = $scope.rep.participants or []
    $scope.team =
      partitipants : []
      competition  : {}
    $scope.teams = []

    console.log $scope.rep

    $scope.methods =
      addParticipant : () ->
        if $scope.participant isnt ''
          $scope.participants.push $scope.participant
          # FirebaseService.updateRepParticipants($scope.rep.id, $scope.participants)
          $scope.participant = ''

      removeParticipant : (index) ->
        $scope.participants.splice(index, 1)

      clear : () ->
        $scope.participants = []

      save : () ->
        FirebaseService.updateRepParticipants($scope.rep.id, $scope.participants)
        FirebaseService.updateRepCompetitions($scope.rep.id, $scope.selectedCompetitions)





    return
