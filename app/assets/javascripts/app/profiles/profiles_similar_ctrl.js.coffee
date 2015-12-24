module.controller 'ProfilesSimilarCtrl', [
  '$scope'
  '$state'
  'similars'
  '$modalInstance'
  '$http'
  ($scope, $state, similars, $modalInstance, $http) ->
    $scope.profiles = similars

    $scope.save =()->
      $modalInstance.close(true)

    $scope.cancel =()->
      $modalInstance.dismiss('cancel')
]

