module.controller 'ProfileEdit', [
  '$scope'
  '$state'
  'Profile'
  '$stateParams'
  '$controller'
  ($scope, $state, Profile, $stateParams, $controller) ->
    $controller('ProfileNew', {$scope: $scope})

    $scope.profile = Profile.$find($stateParams.id)

    $scope.save =()->
      $scope.profile.$save().$then(
        ()->
          toastr['success']('Анкету успішно оновлено.')
        (result)->
          toastr['error']('Помилка!')
      )
]

