module.controller 'DashboardCtrl', [
  '$scope'
  '$state'
  'Account'
  ($scope, $state, Account) ->
    $scope.currentUser = Account.$find('current')
]