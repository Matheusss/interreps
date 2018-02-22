angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
        params:
          logout : null
        templateUrl: 'app/main/template.html'
        controller: 'MainController'
        controllerAs: 'main'
        resolve:
          users: ['FirebaseService', (FirebaseService) ->
            FirebaseService.getAllUsers()
          ]
          reps: ['FirebaseService', (FirebaseService) ->
            FirebaseService.getAllReps()
          ]

    $urlRouterProvider.otherwise '/'
