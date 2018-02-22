angular.module 'interreps'
  .config ($logProvider, toastrConfig) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true

    angular.extend toastrConfig,
      autoDismiss           : yes
      closeButton           : yes
      progressBar           : yes
      preventDuplicates     : no
      preventOpenDuplicates : yes
      newestOnTop           : yes
      maxOpened             : 2
      timeOut               : 5000
      extendedTimeOut       : 5000
      positionClass         : 'toast-top-right'
      target                : 'body'
