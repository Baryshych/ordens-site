module.controller 'ScienceDegreeCtrl', [
  '$scope'
  'ScienceDegree'
  'science_degree_id'
  '$modalInstance'
  ($scope, ScienceDegree, science_degree_id, $modalInstance) ->
    if science_degree_id
      $scope.modalTitle = 'Редагувати науковий ступінь'
      savedNotice = 'Науковий ступінь оновлено'
      notSavedNotice = 'Не вдалося оновити науковий ступінь, помилки:'
      $scope.item = ScienceDegree.$find(science_degree_id)
    else
      $scope.modalTitle = 'Створити науковий ступінь'
      savedNotice = 'Науковий ступінь створено'
      notSavedNotice = 'Не вдалося створити науковий ступінь, помилки:'
      $scope.item = ScienceDegree.$build(title: '')

    $scope.save =()->
      $scope.item.$save().$then(
        (result)->
          # check for warning
          if result.$response.data['warning']
            $scope.warning = true
            toastr['warning']('В базі вже є схожий науковий ступінь')
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
      $scope.item.force_save = true
      $scope.save()

    $scope.useExisting =()->
      $modalInstance.close($scope.existingItem.id)

    $scope.cancel =()->
      $modalInstance.dismiss('cancel')

    $scope.$watch('item.title',
      (text, oldTExt)->
        if text != oldTExt
          $scope.warning = false
    )
]