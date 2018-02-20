angular.module 'interreps'
 .controller 'AdminRepsCreateController', ($rootScope, $scope, $timeout, $interval, $filter, $state, $uibModalStack, FirebaseService) ->
    'ngInject'

    # Definitions
    $scope.rep = {}
    $scope.repsLength = FirebaseService.getAllReps().length

    # Methods
    $scope.methods =
      save : ->
        $scope.rep.id = $scope.repsLength + 1
        FirebaseService.createRep($scope.rep)

      close : ->
        $uibModalStack.dismissAll()

    # Linteners & Watchers


    return
