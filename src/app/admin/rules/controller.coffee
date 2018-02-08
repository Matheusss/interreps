angular.module 'interreps'
 .controller 'AdminRulesController', ($rootScope, $scope, $timeout, $interval, $state, FirebaseService, rules) ->
    'ngInject'

    $scope.rules = rules
    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name

    $scope.methods =
      save : () ->
        FirebaseService.updateRules($scope.rules)

    return
