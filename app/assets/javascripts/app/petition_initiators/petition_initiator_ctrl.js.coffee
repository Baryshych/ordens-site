module.controller 'PetitionInitiatorCtrl', [
  '$scope'
  'PetitionInitiator'
  'petitionInitiatorId'
  '$modalInstance'
  '$controller'
  ($scope, PetitionInitiator, petitionInitiatorId, $modalInstance, $controller) ->
    $controller('ItemModalCtrl', {$scope: $scope, $modalInstance: $modalInstance})
    if petitionInitiatorId
      $scope.modalTitle = 'Редагувати суб\'єкт клопотання'
      savedNotice = 'Суб\'єкт клопотання оновлено'
      notSavedNotice = 'Не вдалося оновити суб\'єкт клопотання, помилки:'
      $scope.item = PetitionInitiator.$find(petitionInitiatorId)
    else
      $scope.modalTitle = 'Створити новий суб\'єкт клопотання'
      savedNotice = 'Новий суб\'єкт клопотання створено'
      notSavedNotice = 'Не вдалося створити суб\'єкт клопотання, помилки:'
      $scope.item = PetitionInitiator.$build(title: '')
]