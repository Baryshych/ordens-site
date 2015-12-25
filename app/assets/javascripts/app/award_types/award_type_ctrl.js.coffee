module.controller 'AwardTypeCtrl', [
  '$scope'
  'AwardType'
  'AwardCategory'
  'awardTypeId'
  '$modalInstance'
  '$controller'
  ($scope, AwardType, AwardCategory, awardTypeId, $modalInstance, $controller) ->
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

    $scope.awardCategories = AwardCategory.$search()
    $scope.awardCategoriesConfig = {
      create: true,
      valueField: 'id',
      labelField: 'title',
      searchField: 'title',
      delimiter: '|',
      placeholder: 'Виберіть категорію або введіть нову',
      maxItems: 1
    }
]
