angular.module 'interreps'
 .controller 'AdminRepsController', ($rootScope, $scope, $timeout, $interval, $filter, $state) ->
    'ngInject'

    storage = firebase.storage()
    $scope.reps = $scope.$parent.reps
    $scope.repsSearched = angular.copy $scope.reps
    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name

  

    # console.log path

    _.map $scope.reps, (rep) ->      

      storage.ref("logos/#{rep.user}.jpg").getDownloadURL()
      .then (url) ->
        $timeout ->
          $scope.url = url
          rep.url = url
          return rep
        # , 1000
      if rep.competitions
        joker = _.find rep.competitions, (comp) -> comp.name is 'Coringa'
        rep.joker = joker.team[0]
      else
        rep.joker = '-' 

    _.map $scope.repsSearched, (rep) ->      

      storage.ref("logos/#{rep.user}.jpg").getDownloadURL()
      .then (url) ->
        $timeout ->
          $scope.url = url
          rep.url = url
          return rep
        # , 1000
      if rep.competitions
        joker = _.find rep.competitions, (comp) -> comp.name is 'Coringa'
        rep.joker = joker.team[0]
      else
        rep.joker = '-' 


    $scope.methods =
      selectRep : (rep) ->
        $scope.selectedRep = rep or undefined

    $scope.$watch 'search', (newVal, oldval) ->
      if newVal isnt ''
        $scope.repsSearched = $filter('filter')($scope.reps, {name: newVal})

      if newVal is ''
        $scope.repsSearched = angular.copy $scope.reps

    return
