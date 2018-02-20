angular.module "interreps"
  .service "StorageService", ($http, $q, $localStorage, $rootScope) ->

    return {

      # Users
      getCurrentUser : () ->
        return $rootScope.currentUser || $localStorage.user

      setCurrentUser : (user) ->
        return $rootScope.currentUser = user

      deleteCurrentUser : () ->
        return $rootScope.currentUser = undefined


    }
