module.controller 'MainCtrl', [
  '$scope'
  '$state'
  'Account'
  '$http'
  ($scope, $state, Account, $http) ->
    $scope.currentUser = Account.$find('current')

    $scope.newPetitions = 0
    checkNewPetitions = ->
      $http.get('/api/v1/petitions/new_count').then (response)->
        $scope.newPetitions = response.data.count
    checkNewPetitions()

    setInterval(checkNewPetitions, 120000)
]
