module.controller 'MainCtrl', [
  '$scope'
  '$state'
  'Account'
  ($scope, $state, Account) ->
    console.log('All right, MAIN!')
    $scope.currentUser = Account.$find('current')

    $scope.newPetitions = 3
]
