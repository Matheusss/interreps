angular.module 'interreps'
 .controller 'RegisterController', ($rootScope, $scope, $timeout, $interval, $localStorage, FirebaseService, rep, competitions, prices) ->
    'ngInject'

    # Definitions
    $scope.rep = rep
    $scope.allCompetitions = competitions
    $scope.prices = prices
    $scope.totalCost = $scope.rep.totalCost or 0
    $scope.selectedPrice = {}
    $scope.img = "../assets/images/#{$scope.rep.user}.jpg"
    $scope.selectedCompetitions = $scope.rep.competitions or []
    $scope.user         = $localStorage.user
    $scope.participant  = {}
    $scope.participants = $scope.rep.participants or []
    $scope.team =
      partitipants : []
      competition  : {}
    $scope.teams = []

    # prices types
    $scope.futebolPrices = ['Futebol', 'Futebol + 1', 'Futebol + 2', 'Futebol + 3', 'Futebol + Queimada + 3 modalidades']
    $scope.queimadaPrices = ['Queimada', 'Queimada 1', 'Queimada 2', 'Queimada 3', 'Futebol + Queimada + 3 modalidades']

    # Methods
    $scope.methods =
      addParticipant : () ->
        if $scope.participant isnt {}
          $scope.participants.push $scope.participant
          $scope.participant = {}

      removeParticipant : (index) ->
        $scope.participants.splice(index, 1)

      clear : () ->
        $scope.participants = []

      save : () ->
        console.log $scope.participants
        FirebaseService.updateRepParticipants($scope.rep.id, $scope.participants)
        FirebaseService.updateRepCompetitions($scope.rep.id, $scope.selectedCompetitions)
        FirebaseService.updateRepTotalCost($scope.rep.id, $scope.totalCost)



    # Listeners & Watchers
    $scope.$watchCollection 'selectedCompetitions', (newVal, oldVal) ->
      $scope.totalCost = 0
      _.each newVal, (item) ->
        price = if item.team then item.price * item.team.length else item.price * 0
        $scope.totalCost += price





    return
