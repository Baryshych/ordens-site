module.controller 'EducationDegreeCtrl', [
  '$scope'
  'EducationDegree'
  'education_degree_id'
  '$modalInstance'
  ($scope, EducationDegree, education_degree_id, $modalInstance) ->
    if education_degree_id
      $scope.modalTitle = 'Редагувати вчене звання'
      savedNotice = 'Вчене звання оновлено'
      notSavedNotice = 'Не вдалося оновити вчене звання, помилки:'
      $scope.item = EducationDegree.$find(education_degree_id)
    else
      $scope.modalTitle = 'Створити вчене звання'
      savedNotice = 'Вчене звання створено'
      notSavedNotice = 'Не вдалося створити вчене звання, помилки:'
      $scope.item = EducationDegree.$build(title: '')

    $scope.save =()->
      $scope.item.$save().$then(
        (result)->
          # check for warning
          if result.$response.data['warning']
            $scope.warning = true
            toastr['warning']('В базі вже є схоже наукове звання')
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