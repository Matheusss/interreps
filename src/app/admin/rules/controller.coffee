angular.module 'interreps'
 .controller 'AdminRulesController', ($rootScope, $scope, $timeout, $interval, FirebaseService, rules) ->
    'ngInject'

    $scope.rules = rules
    $scope.methods =
      save : () ->
        FirebaseService.updateRules($scope.rules)

    return
