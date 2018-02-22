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

      getRepCompetitions : (id) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child('index').child('competitions').once('value')
        .then (result) ->
          return result.val()

      updateRepCompetitions : (id, competitions) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('competitions').set(competitions)

      updateRepParticipants : (id, participants) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('participants').set(participants)

      updateRepTotalCost : (id, totalCost) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('totalCost').set(totalCost)

      createRep : (rep) ->
        database.ref('reps').once('value')
        .then (result) ->
          index = result.val().length
          ref = database.ref('reps')
          ref.child('/' + index).set(rep)

      # Comps
      getAllCompetitions : () ->
        database.ref('competitions').once('value')
        .then (result) ->
          return result.val()

      getCompetitionsArray : () ->
        database.ref('allCompetitions').once('value')
        .then (result) ->
          return result.val()


      updateLeaderboard : (key, leaderboard) ->
        # get all reps
        reps = []
        database.ref('reps').once('value')
          .then (result) ->
            reps = result.val()

        # get all competitions
        database.ref('allCompetitions').once('value')
        .then (result) ->
          index = _.findIndex result.val(), (item) -> item.name is key

          # set competition leaderboard
          database.ref('allCompetitions').child(index).child('leaderboard').set(leaderboard)
          .then (result) ->
            _.each leaderboard, (register) ->
              i = _.findIndex reps, (rep) -> rep.name is register.rep
              rep = _.find reps, (rep) -> rep.name is register.rep
              compIndex = _.findIndex rep.competitions, (comp) -> comp.name is key

              database.ref('reps').child(i).child('competitions').child(compIndex).child('position').set(register.position)


      # Rules
      getRules : () ->
        database.ref('rules').once('value')
        .then (result) ->
          return result.val()

      updateRules : (rules) ->
        database.ref('rules').set(rules)


      # Prices
      getPrices : () ->
        database.ref('prices').once('value')
        .then (result) ->
          return result.val()

    }
