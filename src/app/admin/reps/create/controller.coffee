angular.module 'interreps'
 .controller 'AdminRepsCreateController', ($rootScope, $scope, $timeout, $interval, $filter, $state, FirebaseService) ->
    'ngInject'

    # Definitions
    $scope.rep = {}

    # Methods
    $scope.methods =
      save : ->
        FirebaseService.createRep($scope.rep)

    # Linteners & Watchers


    return
