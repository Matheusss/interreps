angular.module 'interreps'
 .controller 'AdminRepsDetailsController', ($rootScope, $scope, $timeout, $interval, $filter, $state, $uibModalStack, rep) ->
    'ngInject'

    # Definitions
    $scope.rep = rep
    console.log rep

    # Methods
    $scope.methods =
      close : ->
        $uibModalStack.dismissAll()

    # Linteners & Watchers


    return
