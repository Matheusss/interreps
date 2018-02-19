angular.module 'interreps'
 .controller 'AdminRepsCreateController', ($rootScope, $scope, $timeout, $interval, $filter, $state, $uibModalStack, FirebaseService) ->
    'ngInject'

    # Definitions
    $scope.rep = {}

    # Methods
    $scope.methods =
      save : ->
        FirebaseService.createRep($scope.rep)

      close : ->
        $uibModalStack.dismissAll()

    # Linteners & Watchers


    return
