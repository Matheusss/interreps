angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'admin',
        url: '/admin'
        templateUrl: 'app/admin/template.html'
        controller: 'AdminController'
        controllerAs: 'admin'
