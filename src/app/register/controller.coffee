angular.module 'interreps'
 .controller 'RegisterController', ($rootScope, $scope, $timeout, $interval, $localStorage) ->
    'ngInject'

    $scope.user = $localStorage.user
    storage = firebase.storage()
    $scope.img = "../../assets/images/#{$scope.user.user}.jpg"
    $scope.methods = {}


    return
