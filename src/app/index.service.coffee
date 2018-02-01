angular.module "interreps"
  .service "FirebaseService", ($http, $q) ->
    database = firebase.database()
    auth    = firebase.auth()

    return {

      getCurrentAuthuser : () ->
        return auth.currentUser

      getAllUsers : () ->
        database.ref('users').once('value')
        .then (result) ->
          return result.val()

      getAllReps : () ->
        database.ref('reps').once('value')
        .then (result) ->
          return result.val()

    }
