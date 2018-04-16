angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'register',
        url: '/register'
        params: { id: null }
        templateUrl: 'app/register/template.html'
        controller: 'RegisterController'
        controllerAs: 'register'
        resolve :
           rep: ['FirebaseService', 'StorageService', (FirebaseService, StorageService) ->
              user = StorageService.getCurrentUser()
              FirebaseService.getRepById(user.id)
            ]
           competitions: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllCompetitions()
            ]
           prices: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getPrices()
            ]
           rules: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getRules()
            ]

           reps: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllReps()
            ]

           allCompetitionsArray: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getCompetitionsArray()
            ]

           points: ['FirebaseService', (FirebaseService) ->
              FirebaseService.updatePoints()
            ]
