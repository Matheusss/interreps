angular.module 'interreps'
 .controller 'RegisterController', ($rootScope, $scope, $state, $timeout, $interval, $localStorage, FirebaseService, StorageService, toastr, rep, reps, rules, competitions, allCompetitionsArray, prices) ->
    'ngInject'

    # Definitions
    storage = firebase.storage()

    $scope.rep                  = rep
    $scope.reps                 = reps
    $scope.updatedReps          = angular.copy $scope.reps

    $scope.rules                = rules

    $scope.allCompetitions      = competitions
    $scope.allCompetitionsArray = allCompetitionsArray
    $scope.prices               = prices
    $scope.totalCost            = $scope.rep.totalCost or 0
    $scope.selectedPrice        = {}
    $scope.img                  = "../assets/images/#{$scope.rep.user}.jpg"
    $scope.selectedCompetitions = $scope.rep.competitions or []
    $scope.user                 = StorageService.getCurrentUser().user
    $scope.participants         = $scope.rep.participants or []
    $scope.parts                = angular.copy $scope.participants
    $scope.filter =
      genre : 'G'
      competitions: 'T'

    $scope.currentMenu          = {
      name: 'Cadastro'
      icon: 'fas fa-users fa-lg'
      value: 'register'
    }
    $rootScope.menu = [
      {
        name: 'Cadastro'
        icon: 'fas fa-users fa-lg'
        value: 'register'
      }
      {
        name: 'Horários'
        icon: 'fas fa-clock fa-lg'
        value: 'schedules'
      }
      # {
      #   name: 'Placar'
      #   icon: 'fas fa-trophy fa-lg'
      #   value: 'scores'
      # }
      {
        name: 'Regulamento'
        icon: 'fas fa-exclamation-circle fa-lg'
        value: 'rules'
      }
    ]

    $scope.formInvalid          =
      invalid : no
      errors  : []

    $scope.participant          = {}
    $scope.teams                = []
    $scope.team                 =
      partitipants : []
      competition  : {}

    storage.ref("logos/#{$scope.rep.user}.jpg").getDownloadURL()
      .then (url) ->
        $timeout ->
          rep.url = url

    # Methods
    $scope.methods =
      init : ->
        $scope.leaderboard = []
        $scope.selectedReps = []
        _.each $scope.reps, (rep) ->
          index = _.indexOf $scope.reps, rep
          obj =
            position: index + 1
            rep     : {}

          $scope.leaderboard.push obj

        _.map $scope.allCompetitionsArray, (competition) ->
          matches = competition.name.match(/\b(\w)/g)
          competition.initials = matches.join('')

        _.map $scope.updatedReps, (rep) ->
          _.each $scope.allCompetitionsArray, (comp) ->
           index = _.findIndex rep.competitions, (c) -> c.name is comp.name
           if index is -1
             rep.competitions = rep.competitions || []
             rep.competitions.push({
               name: comp.name
               })


      genreFilter : (item) ->
        if $scope.filter.genre is 'G'
          return item
        else
          return item.genre is $scope.filter.genre

      setCurrentMenu : (menu) ->
        $scope.currentMenu = menu
        console.log(menu, $scope.currentMenu)

      logout : () ->
        StorageService.deleteCurrentUser()
        $state.go 'home', {logout: yes}

      clearTeam : (item) ->
        if item.team
          item.team = []

      addParticipant : () ->
        if $scope.participant isnt {}
          $scope.participants.push $scope.participant
          $scope.participant = {}

      removeParticipant : (index) ->
        $scope.participants.splice(index, 1)

      clear : () ->
        $scope.participants = []

      validateForm : () ->
        $scope.formInvalid.errors = []
        repAllowedComps = if $scope.parts >= 10 then 3 else 4
        excludes = _.filter $scope.selectedCompetitions, (comp) -> comp.name is 'Futebol' or comp.name is 'Queimada'
        _.each $scope.parts, (part) ->
          # more than 3 comps, excluding those on 'excludes' variable, per participant
          comps = []
          comps = _.difference part.competitions, excludes
          if comps.length > repAllowedComps
            $scope.formInvalid.invalid = yes
            $scope.formInvalid.errors.push "#{part.name} está participando de #{comps.length} provas. O máximo permitido é #{repAllowedComps}"

        if $scope.formInvalid.invalid
          toastr.error '', '', {
            extraData :
              formInvalid     : $scope.formInvalid
            templates         :
          	  toast: 'directives/toast/toast.html',

          }
        else
          $scope.formInvalid.invalid = no
          $scope.methods.save()
          # console.log $scope.parts



      save : () ->
        # console.log $scope.parts
        FirebaseService.updateRepTotalCost($scope.rep.id, $scope.totalCost)
        FirebaseService.updateRepParticipants($scope.rep.id, $scope.participants)
        FirebaseService.updateRepCompetitions($scope.rep.id, $scope.selectedCompetitions)
        toastr.success 'Resgistro salvo com sucesso'

      addCompsToParticipant : (item) ->
        if item.team
          _.map $scope.parts, (part) ->
            part.competitions = part.competitions or []
            isPartOfTeam = _.find item.team, (p) -> p.name is part.name
            isParticipating = _.find part.competitions, (c) -> c.name is item.name

            part.competitions.push item if isPartOfTeam  and !_.find part.competitions, (c) -> c.name is item.name

            if !isPartOfTeam and isParticipating
              index = part.competitions.indexOf item
              part.competitions.splice index, 1

      getTotalPrice : (newVal) ->
        $scope.totalCost = 0
        _.each newVal, (item) ->
          price = if item.team then item.price * item.team.length else item.price * 0
          $scope.totalCost += price
          $scope.methods.addCompsToParticipant(item)

          # if item.team
          #   _.map $scope.participants, (participant) ->
              # participant.competitions = participant.competitions or []
              # participant.competitions.push item if _.find item.team, (p) -> p.name is participant.name



    # Listeners & Watchers
    $scope.$watch 'selectedCompetitions', (newVal, oldVal) ->
      $scope.methods.getTotalPrice(newVal)
    , yes


    $scope.methods.init()
    return
