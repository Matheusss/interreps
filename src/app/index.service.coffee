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

      updateRepCompetitions : (id, competitions) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('competitions').set(competitions)

      createRep : (rep) ->
        database.ref('reps').once('value')
        .then (result) ->
          repsLength = result.val().length
          ref = database.ref('reps')
          ref.child('/' + repsLength).set(rep)


      # Comps
      getAllCompetitions : () ->
        database.ref('competitions').once('value')
        .then (result) ->
          return result.val()

      # Rules
      getRules : () ->
        database.ref('rules').once('value')
        .then (result) ->
          return result.val()

      updateRules : (rules) ->
        database.ref('rules').set(rules)

    }
