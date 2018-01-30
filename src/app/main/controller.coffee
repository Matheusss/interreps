angular.module 'interreps'
 .controller 'MainController', ($rootScope, $scope, $state, $timeout, $interval, HomeService) ->
    'ngInject'

    $scope.user =
      email: undefined
      password: undefined

    $scope.methods =
      login : () ->
        firebase.auth().signInWithEmailAndPassword($scope.user.email, $scope.user.password)
        .then (result) ->
          $state.go 'admin'
        .catch (error) ->
          console.log error
          # if user exist in db then
          $state.go 'register'


    return
