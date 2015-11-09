module.controller 'WorkplaceCtrl', [
  '$scope'
  'Workplace'
  '$modalInstance'
  'workplace_id'
  ($scope, Workplace, $modalInstance, workplace_id) ->
    if workplace_id
      $scope.modalTitle = 'Редагувати'
      savedNotice = 'Місце роботи оновлено'
      notSavedNotice = 'Не вдалося оновити місце роботи, помилки'
      $scope.workplace = Workplace.$find(workplace_id)
    else
      $scope.modalTitle = 'Додати'
      savedNotice = 'Створено нове місце роботи'
      notSavedNotice = 'Не вдалося створити місце роботи, помилки:'
      $scope.workplace = Workplace.$build(title: '', address: '')

    $scope.save =()->
      $scope.workplace.$save().$then(
        (result)->
          # check for warning
          if result.$response.data['warning']
            $scope.warning = true
            toastr['warning']('В базі вже є схоже місце роботи')
            $scope.existingItem = result.$response.data['existing_item']
          else
            $modalInstance.close(result.$response.data['id'])
            toastr['success'](savedNotice)
        (result)->
          toastr['error'](
            result.$response.data['errors'].join('<br>'),
            notSavedNotice,
            bodyOutputType: 'trustedHtml'
          )
      )

    $scope.forceSave =()->
      $scope.workplace.force_save = true
      $scope.save()

    $scope.useExisting =()->
      $modalInstance.close($scope.existingItem.id)

    $scope.cancel =()->
      $modalInstance.dismiss('cancel')
]