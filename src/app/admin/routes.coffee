angular.module 'interreps'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'admin',
        url: '/admin/:id'
        abstract: yes
        params: { id: null }
        templateUrl: 'app/admin/template.html'
        controller: 'AdminController'
        resolve :
           reps: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllReps()
            ]
           user: ['FirebaseService', '$stateParams', (FirebaseService, $stateParams) ->
              FirebaseService.getUserById($stateParams.id)
            ]

      .state 'admin.reps',
        url: '/reps'
        templateUrl: 'app/admin/reps/template.html'
        controller: 'AdminRepsController'

      .state 'admin.schedules',
        url: '/schedules'
        templateUrl: 'app/admin/schedules/template.html'
        controller: 'AdminSchedulesController'

      .state 'admin.scores',
        url: '/scores'
        templateUrl: 'app/admin/scores/template.html'
        controller: 'AdminScoresController'
        resolve :
           reps: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllReps()
            ]
           competitions: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getAllCompetitions()
            ]

           allCompetitionsArray: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getCompetitionsArray()
            ]

           points: ['FirebaseService', (FirebaseService) ->
              FirebaseService.updatePoints()
            ]

      .state 'admin.rules',
        url: '/rules'
        templateUrl: 'app/admin/rules/template.html'
        controller: 'AdminRulesController'
        resolve :
           rules: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getRules()
            ]
