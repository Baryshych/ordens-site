module.controller 'UserCtrl', [
  '$scope'
  'User'
  'userId'
  '$modalInstance',
  '$controller'
  ($scope, User, userId, $modalInstance, $controller) ->
    $controller('ItemModalCtrl', {$scope: $scope, $modalInstance: $modalInstance})
    if userId
      $scope.modalTitle = 'Редагувати користувача'
      savedNotice = "Збережено"
      notSavedNotice = "Не вдалося зберегти, помилки:"
      $scope.item = User.$find(userId)
    else
      $scope.modalTitle = 'Створити користувача'
      $scope.item = User.$build()
]

