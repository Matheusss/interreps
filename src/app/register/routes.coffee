angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'register',
        url: '/register'
        templateUrl: 'app/register/template.html'
        controller: 'RegisterController'
        controllerAs: 'register'
