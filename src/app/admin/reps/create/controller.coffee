angular.module 'interreps'
 .controller 'AdminRepsCreateController', ($rootScope, $scope, $timeout, $interval, $filter, $state, $uibModalStack, FirebaseService, toastr, reps) ->
    'ngInject'

    # Definitions
    $scope.rep = {}
    $scope.reps = reps

    # Methods
    $scope.methods =
      save : ->
        $scope.rep.id = $scope.reps.length ? $scope.reps.length + 1 : 1
        FirebaseService.createRep($scope.rep)
        toastr.success 'República criada com sucesso'
        $timeout () ->
          $scope.methods.close()
        , 500

      close : ->
        $uibModalStack.dismissAll()

    # Linteners & Watchers


    return
