angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'register',
        url: '/register/:id'
        params: { id: null }
        templateUrl: 'app/register/template.html'
        controller: 'RegisterController'
        controllerAs: 'register'
        resolve :
           rep: ['FirebaseService', '$stateParams', (FirebaseService, $stateParams) ->
              FirebaseService.getRepById($stateParams.id)
            ]
           competitions: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllCompetitions()
            ]
