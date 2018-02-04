angular.module "interreps"
  .service "FirebaseService", ($http, $q) ->
    database = firebase.database()
    auth    = firebase.auth()

    return {

      # Users
      getCurrentAuthuser : () ->
        return auth.currentUser

      getAllUsers : () ->
        database.ref('users').once('value')
        .then (result) ->
          return result.val()

      getUserById : (id) ->
        id = parseInt(id)
        index = id - 1
        database.ref('users').child(index).once('value')
        .then (result) ->
          return result.val()


      # Reps
      getAllReps : () ->
        database.ref('reps').once('value')
        .then (result) ->
          return result.val()

      getRepById : (id) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).once('value')
        .then (result) ->
          return result.val()

      updateRepParticipants : (id, participants) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('participants').set(participants)


      # Comps
      getAllCompetitions : () ->
        database.ref('competitions').once('value')
        .then (result) ->
          return result.val()

    }
