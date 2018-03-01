angular.module "interreps"
  .service "FirebaseService", ($http, $q) ->
    database = firebase.database()
    auth    = firebase.auth()

    service = {

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

      getAllRepsOrderedByPoints : () ->
        database.ref('reps').orderByKey('points')
        .then (result) ->
          console.log result.val()
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

      updateRepPoints : (id, points) ->
        id = parseInt(id)
        index = id - 1
        database.ref('reps').child(index).child('points').set(points)

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
          allCompetitions = result.val()
          compAllIndex = _.findIndex allCompetitions, (comp) -> comp.name is key
          # set competition leaderboard
          database.ref('allCompetitions').child(index).child('leaderboard').set(leaderboard)
          .then (result) ->
            _.each leaderboard, (register) ->
              if register.rep isnt {}
                i = _.findIndex reps, (rep) -> rep.name is register.rep.name
                rep = _.find reps, (rep) -> rep.name is register.rep.name
                compIndex = _.findIndex rep.competitions, (comp) -> comp.name is key
                if i isnt -1 and compIndex isnt -1
                  database.ref('reps').child(i).child('competitions').child(compIndex).child('position').set(register.position)
                  database.ref('reps').child(i).child('competitions').child(compIndex).child('points').set(allCompetitions[compAllIndex].points[register.position - 1])

        service.updatePoints()

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


      # Leaderboard
      updatePoints : ->
        $q.all({
          reps         : service.getAllReps()
          competitions : service.getCompetitionsArray()
        })
        .then (result) ->
          reps = result.reps
          competitions = result.competitions

          _.each reps, (rep) ->
            rep.points = 0
            _.each competitions, (comp) ->
              if comp.leaderboard
                _.each comp.leaderboard, (item) ->
                  if item.rep and rep.name is item.rep.name
                    rep.points += comp.points[item.position - 1]
            service.updateRepPoints(rep.id, rep.points)
    }

    return service
