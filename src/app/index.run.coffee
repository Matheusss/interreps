angular.module 'interreps'
  .run ($log, $rootScope, $state, StorageService) ->
    'ngInject'
    $log.debug 'runBlock end'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      console.log StorageService.getCurrentUser()
      if !StorageService.getCurrentUser() and fromState.name isnt ''
        # event.preventDefault()
        $state.go 'home'
