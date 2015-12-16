module.controller 'SelectsCtrl', [
  '$scope'
  '$state'
  'Profile'
  '$timeout'
  ($scope, $state, Profile, $timeout) ->

    queryParams = { }

    loadProfiles =(queryParams)->
      Profile.$search(queryParams).$then (result) ->
        $scope.profiles = result
        
    loadProfiles()

]

