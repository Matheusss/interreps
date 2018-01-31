angular.module 'interreps'
 .controller 'MainController', ($rootScope, $scope, $state, $timeout, $interval, $localStorage, ADMINS) ->
    'ngInject'


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
          # console.log result
          isAdmin = _.contains ADMINS, result.uid
          $scope.$storage.user = result
          $timeout () ->
            if isAdmin
              $state.go 'admin'
            else
              $state.go 'register'
          , 2000

        .catch (error) ->
          console.log error

    return
