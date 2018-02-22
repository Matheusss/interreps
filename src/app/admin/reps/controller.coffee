angular.module 'interreps'
 .controller 'AdminRepsController', ($rootScope, $scope, $timeout, $interval, $filter, $state, $uibModal, FirebaseService) ->
    'ngInject'

    # Definitions
    storage = firebase.storage()
    $scope.reps = $scope.$parent.reps
    $scope.repsSearched = angular.copy $scope.reps
    $rootScope.currentState = _.find $rootScope.menu, (item) -> item.state is $state.current.name



    # Methods
    $scope.methods =
      init : ->
        _.map $scope.reps, (rep) ->
          storage.ref("logos/#{rep.user}.jpg").getDownloadURL()
          .then (url) ->
            $timeout ->
              rep.url = url
              return rep
          if rep.competitions
            joker = _.find rep.competitions, (comp) -> comp.name is 'Coringa'
            rep.joker = if joker then joker.team[0] else ''
          else
            rep.joker = '-'

        _.map $scope.repsSearched, (rep) ->
          storage.ref("logos/#{rep.user}.jpg").getDownloadURL()
          .then (url) ->
            $timeout ->
              rep.url = url
              return rep
          if rep.competitions
            joker = _.find rep.competitions, (comp) -> comp.name is 'Coringa'
            rep.joker = if joker then joker.team[0] else ''
          else
            rep.joker = '-'

      getDetails : (rep) ->
        modalInstance = $uibModal.open(
          animation: yes
          windowTemplateUrl: 'window-template.html'
          templateUrl: 'details.html'
          controller: 'AdminRepsDetailsController'
          backdrop: 'no'
          resolve: rep: ->
            return rep
        )

      createRep : () ->
        modalInstance = $uibModal.open(
          animation: yes
          windowTemplateUrl: 'window-template.html'
          templateUrl: 'create.html'
          controller: 'AdminRepsCreateController'
          backdrop: 'no'
          resolve: reps: ->
            return $scope.reps
        )
        modalInstance.result.then ((reps) ->
          console.log 'closed'
        ), ->
          FirebaseService.getAllReps()
          .then (result) ->
            $scope.reps = result
            $scope.repsSearched = angular.copy $scope.reps
            $scope.methods.init()

    # Linteners & Watchers
    $scope.$watch 'search', (newVal, oldval) ->
      if newVal isnt ''
        $scope.repsSearched = $filter('filter')($scope.reps, {name: newVal})

      if newVal is ''
        $scope.repsSearched = angular.copy $scope.reps

    $scope.methods.init()
    return
