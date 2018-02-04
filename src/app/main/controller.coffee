angular.module 'interreps'
  .directive "ngBgSlideshow", ($interval) ->
    'ngInject'
    restrict    : 'A'
    scope       :
      ngBgSlideshow : '&'
      interval : '='
    templateUrl : 'app/components/bgCarousel/template.html'

    link : (scope, elem, attr) ->
      scope.$watch 'ngBgSlideshow', (val) ->
        scope.images = val()
        scope.active_image = 0

      change = $interval((->
        scope.active_image++
        if scope.active_image >= scope.images.length
          scope.active_image = 0
        return
      ), scope.interval or 1000)

 .controller 'MainController', ($rootScope, $scope, $state, $timeout, $interval, $localStorage, ADMINS, FirebaseService, users, reps) ->
    'ngInject'

    $scope.users = users
    $scope.reps = reps
    $scope.$storage = $localStorage
    $scope.showForm = no
    $scope.user =
      email: undefined
      password: undefined

    $scope.methods =
      changeView : () ->
        $scope.showForm = !$scope.showForm

      login : () ->
        firebase.auth().signInWithEmailAndPassword($scope.user.email, $scope.user.password)
        .then (result) ->
          currentUser = _.find $scope.users, (user) -> user.uid is result.uid
          currentRep  = _.find $scope.reps, (rep) -> rep.uid is result.uid

          if currentUser
            $scope.$storage.user = currentUser
            $timeout () ->
              $state.go 'admin.reps', {id: currentUser.id}
            1000
          else
            if currentRep
              $scope.$storage.user = currentRep
              $timeout () ->
                $state.go 'register', {id: currentRep.id}
              , 1000




          # $state.go 'admin'
          # $state.go 'register'


        .catch (error) ->
          console.log error

    return
