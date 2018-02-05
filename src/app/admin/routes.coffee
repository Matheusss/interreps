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
        controllerAs: 'admin'
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
        controllerAs: 'admin'

      .state 'admin.schedules',
        url: '/schedules'
        templateUrl: 'app/admin/schedules/template.html'
        controller: 'AdminSchedulesController'
        controllerAs: 'admin'

      .state 'admin.rules',
        url: '/rules'
        templateUrl: 'app/admin/rules/template.html'
        controller: 'AdminRulesController'
        controllerAs: 'admin'
        resolve :
           rules: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getRules()
            ]
