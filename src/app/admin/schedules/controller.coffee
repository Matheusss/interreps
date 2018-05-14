angular.module 'interreps'
 .controller 'AdminSchedulesController', ($rootScope, $scope, $timeout, $interval, $state, FirebaseService) ->
    'ngInject'

    storage = firebase.storage()
    $scope.schedule = ''

    storage.ref("assets/schedule.PNG").getDownloadURL()
    .then (url) ->
      $timeout ->
        $scope.schedule = url

    return
