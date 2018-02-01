angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
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
