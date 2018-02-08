angular.module 'interreps'
 .controller 'AdminRepsController', ($rootScope, $scope, $timeout, $interval) ->
    'ngInject'

    storage = firebase.storage()
    $scope.reps = $scope.$parent.reps

    # console.log path

    _.map $scope.reps, (rep) ->
      
      if rep.competitions
        rep.joker = _.find rep.competitions, (comp) -> comp.name is 'Coringa'
      else
        rep.joker = ''       

      storage.ref("logos/#{rep.user}.jpg").getDownloadURL()
      .then (url) ->
        $timeout ->
          $scope.url = url
          rep.url = url
          return rep
        # , 1000

    $scope.methods =
      selectRep : (rep) ->
        $scope.selectedRep = rep or undefined

    return
