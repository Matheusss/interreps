angular.module 'interreps'
 .controller 'RegisterController', ($rootScope, $scope, $timeout, $interval, $localStorage, FirebaseService, rep, competitions) ->
    'ngInject'

    $scope.rep = rep
    $scope.allCompetitions = competitions
    $scope.img = "../assets/images/#{$scope.rep.user}.jpg"
    $scope.selectedCompetitions = []
    $scope.user         = $localStorage.user
    $scope.participant  = ''
    $scope.participants = []
    $scope.team =
      partitipants : []
      competition  : {}
    $scope.teams = []

    $scope.methods =
      addParticipant : () ->
        if $scope.participant isnt ''
          $scope.participants.push $scope.participant
          FirebaseService.updateRepParticipants($scope.rep.id, $scope.participants)
          $scope.participant = ''

      removeParticipant : (index) ->
        $scope.participants.splice(index, 1)

      clear : () ->
        $scope.participants = []



    return
