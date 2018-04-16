angular.module 'interreps'
  .run ($log, $rootScope, $state, $templateCache, StorageService, offline, connectionStatus) ->
    'ngInject'
    $log.debug 'runBlock end'

    connectionStatus.$on 'online', () ->
      console.log 'online'

    connectionStatus.$on 'offline', () ->
      console.log 'offline'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if !StorageService.getCurrentUser().user and fromState.name isnt ''
        console.log '1'
        if !toParams.logout
          event.preventDefault()
          $state.go 'home'

      if StorageService.getCurrentUser().user and toState.name is 'home'
        console.log '2'
        event.preventDefault()

      if StorageService.getCurrentUser().user and (fromState.name is '' and toState.name is 'home')
        console.log '3'
        if StorageService.getCurrentUser().type is 'admin'
          $state.go 'admin.reps', {id: StorageService.getCurrentUser().user.id}
        else
          $state.go 'register', {id: StorageService.getCurrentUser().user.id}

    $templateCache.put('directives/toast/toast.html',
      '<div class="{{toastClass}} {{toastType}}" ng-click="tapToast()">' +
      '  <div ng-switch on="allowHtml">' +
      '    <div ng-switch-default ng-if="title" class="{{titleClass}}" aria-label="{{title}} style="font-size:20px!important; margin-bottom:10px; padding-left:40px; letter-spacing:1;">{{title}}</div>' +
      '    <div ng-switch-default class="{{messageClass}}" aria-label="{{message}}" >{{message}}</div>' +
      '    <div ng-switch-when="true" ng-if="title" class="{{titleClass}}" ng-bind-html="title" style="font-size:20px!important; margin-bottom:10px; padding-left:40px; letter-spacing:1;"></div>' +
      '    <div ng-switch-when="true" class="{{messageClass}}" ng-bind-html="message" ></div>' +
      '  </div>' +
      '  <ul class"errors" style="padding: 0 0 0 20px;">' +
      '   <li ng-repeat="error in extraData.formInvalid.errors track by $index"><span>{{error}}</span></li>' +
      '  </ul>' +
      '  <progress-bar ng-if="progressBar"></progress-bar>' +
      '</div>'


    )
