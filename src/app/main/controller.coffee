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

 .controller 'MainController', ($rootScope, $scope, $state, $timeout, $interval, $localStorage, FirebaseService, StorageService, toastr, users, reps) ->
    'ngInject'

    $scope.users = users
    $scope.reps = reps
    $scope.$storage = $localStorage
    $scope.showForm = no
    $scope.user =
      email: undefined
      password: undefined
      user: undefined

    storage = firebase.storage()

    $scope.images = []

    $scope.methods =
      getImages : () ->
        i = 1
        imagesLength = 17
        $scope.images = []

        for index in [i..imagesLength]
          storage.ref("images/#{index}.jpg").getDownloadURL()
          .then (url) ->
            if url
              $scope.images.push url

        $scope.images = _.shuffle($scope.images)

      changeView : () ->
        $scope.showForm = !$scope.showForm

      login : () ->
        StorageService.deleteCurrentUser()

        currentUser = _.find $scope.users, (user) -> user.user is $scope.user.user and user.password is $scope.user.password
        currentRep  = _.find $scope.reps, (rep) -> rep.user is $scope.user.user and rep.password is $scope.user.password

        if currentUser
          user = {type: 'admin', user: currentUser}
          StorageService.setCurrentUser(user)
          $timeout () ->
            $state.go 'admin.reps', {id: currentUser.id}
          , 1000

        if currentRep
          user = {type: 'rep', user: currentRep}
          StorageService.setCurrentUser(currentRep)
          $timeout () ->
            $state.go 'register', {id: currentRep.id}
          , 1000

        if !currentUser and !currentRep
          toastr.error 'Login e/ou senha inválido(s)'


    $scope.methods.getImages()
    return
