angular.module "interreps"
  .service "StorageService", ($http, $q, $localStorage, $rootScope) ->

    return {

      # Users
      getCurrentUser : () ->
        return $localStorage.user 

      setCurrentUser : (user) ->
        return $localStorage.user = user

      deleteCurrentUser : () ->
        return $localStorage.user = {}


    }
