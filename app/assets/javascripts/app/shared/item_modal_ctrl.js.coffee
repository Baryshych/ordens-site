module.controller 'ItemModalCtrl', [
  '$scope'
  '$modalInstance'
  ($scope, $modalInstance) ->
    savedNotice = "Збережено"
    notSavedNotice = "Не вдалося зберегти, помилки:"
    
    $scope.save =()->
      $scope.item.$save().$then(
        (result)->
          # check for warning
          if result.$response.data['warning']
            $scope.warning = true
            toastr['warning']('В базі знайдено подібне значення')
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