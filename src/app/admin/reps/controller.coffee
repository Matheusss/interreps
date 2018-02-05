angular.module 'interreps'
 .controller 'AdminRepsController', ($rootScope, $scope, $timeout, $interval) ->
    'ngInject'

    storage = firebase.storage()
    $scope.reps = $scope.$parent.reps
    $scope.selectedRep = undefined

    # console.log path

    _.map $scope.reps, (rep) ->

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
