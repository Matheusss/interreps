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

      # .state 'admin.rep-create',
      #   url: '/reps/new'
      #   templateUrl: 'app/admin/reps/create/template.html'
      #   controller: 'AdminRepsCreateController'
      #
      # .state 'admin.rep-details',
      #   url: '/reps/details/:id'
      #   params: { id: null }
      #   templateUrl: 'app/admin/reps/details/template.html'
      #   controller: 'AdminRepsDetailsController'
      #   resolve :
      #      rep: ['FirebaseService', '$stateParams', (FirebaseService, $stateParams) ->
      #         FirebaseService.getRepById($stateParams.id)
      #       ]

      .state 'admin.schedules',
        url: '/schedules'
        templateUrl: 'app/admin/schedules/template.html'
        controller: 'AdminSchedulesController'

      .state 'admin.rules',
        url: '/rules'
        templateUrl: 'app/admin/rules/template.html'
        controller: 'AdminRulesController'
        resolve :
           rules: ['FirebaseService', (FirebaseService) ->
              FirebaseService.getRules()
            ]
