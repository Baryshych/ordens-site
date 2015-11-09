module.controller 'AwardTypeCtrl', [
  '$scope'
  'AwardType'
  'awardTypeId'
  '$modalInstance'
  '$controller'
  ($scope, AwardType, awardTypeId, $modalInstance, $controller) ->
    $controller('ItemModalCtrl', {$scope: $scope, $modalInstance: $modalInstance})
    if awardTypeId
      $scope.modalTitle = 'Редагувати тип нагороди'
      savedNotice = 'Тип нагороди оновлено'
      notSavedNotice = 'Не вдалося оновити тип нагороди, помилки:'
      $scope.item = AwardType.$find(awardTypeId)
    else
      $scope.modalTitle = 'Створити новий тип нагороди'
      savedNotice = 'Новий тип нагороди створено'
      notSavedNotice = 'Не вдалося створити тип нагороди, помилки:'
      $scope.item = AwardType.$build(title: '')
]