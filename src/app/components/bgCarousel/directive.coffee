# angular.module 'interreps'
#   .directive "ngBgSlideshow", ($interval) ->
#     'ngInject'
#     restrict    : 'A'
#     scope       :
#       ngBgSlideshow : '&'
#       interval : '='
#     templateUrl : 'app/components/bgCarousel/template.html'
#
#     link : (scope, elem, attr) ->
#       scope.$watch 'ngBgSlideshow', (val) ->
#         scope.images = val
#         scope.active_image = 0
#
#       change = $interval((->
#         scope.active_image++
#         if scope.active_image >= scope.images.length
#           scope.active_image = 0
#         return
#       ), scope.interval or 1000)
