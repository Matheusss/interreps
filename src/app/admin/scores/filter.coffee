'use strict'

angular.module "interreps"
  .filter "newArrayFilter", () ->

    return (reps, competitions) ->
      _.each reps, (rep) ->
        _.each competitions, (comp) ->
         index = _.findIndex rep.competitions, (c) -> c.name is comp.name
         if index isnt > -1
          rep.competitions.push({
            name: comp.name
            })

      return reps
