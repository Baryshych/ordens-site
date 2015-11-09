module.controller 'DocumentQualityCtrl', [
  '$scope'
  'DocumentQuality'
  'documentQualityId'
  '$modalInstance'
  '$controller'
  ($scope, DocumentQuality, documentQualityId, $modalInstance, $controller) ->
    $controller('ItemModalCtrl', {$scope: $scope, $modalInstance: $modalInstance})
    if documentQualityId
      $scope.modalTitle = 'Редагувати опис документів'
      savedNotice = 'Опис документів оновлено'
      notSavedNotice = 'Не вдалося оновити опис документів, помилки:'
      $scope.item = DocumentQuality.$find(documentQualityId)
    else
      $scope.modalTitle = 'Створити новий опис документів'
      savedNotice = 'Новий опис документів створено'
      notSavedNotice = 'Не вдалося створити опис документів, помилки:'
      $scope.item = DocumentQuality.$build(title: '')
]