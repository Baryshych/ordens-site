module.controller 'AwardCtrl', [
  '$scope'
  '$state'
  'Award'
  'AwardType'
  'PetitionInitiator'
  'DocumentQuality'
  '$stateParams'
  ($scope, $state, Award, AwardType, PetitionInitiator, DocumentQuality, $stateParams) ->
    if $stateParams.id
      $scope.title = "Редагувати нагороду"
      savedNotice = 'Дані нагороли оновлено'
      notSavedNotice = 'Не вдалося оновити дані'
      $scope.award = Award.$find($stateParams.id)
    else
      $scope.title = "Додати дані про нагороду"
      savedNotice = 'Нагороду створено'
      notSavedNotice = 'Не вдалося створити нагороду'
      $scope.award = Award.$build(
        profile_id: $stateParams.profileId
        result: 'Невідомо'
      )

    $scope.save =()->
      $scope.award.$save().$then(
        ()->
          toastr['success'](savedNotice)
          $state.go('profileEdit', {id: $stateParams.profileId})
        (result)->
          toastr['error'](notSavedNotice)
      )

    $scope.destroy =()->
      conf = confirm('Ви впевнені що хочете видалити цю нагороду?')
      if conf
        $scope.award.$destroy().$then(
          ()->
            toastr['warning']('Нагорода видалена')
            $state.go('profileEdit', {id: $stateParams.profileId})
          (result)->
            toastr['error']('Не вдалося видалити нагороду')
        )

    $scope.awardTypes = AwardType.$search()
    $scope.awardTypesConfig = {
      create: false,
      valueField: 'id',
      labelField: 'title',
      searchField: 'title',
      delimiter: '|',
      placeholder: 'Виберіть або введіть текст для пошуку',
      maxItems: 1
    }

    $scope.dateOptions = {
      startingDay: 1
    }

    $scope.awardStatuses = [
      { value: 'очікує розгляду' },
      { value: 'підтримано' },
      { value: 'відхилено' },
      { value: 'підтримано як виняток' },
      { value: 'знято з розгляду' }
    ]
    $scope.awardStatusesConfig = {
      create: false,
      valueField: 'value',
      labelField: 'value',
      placeholder: 'Виберіть статус',
      maxItems: 1
    }

    $scope.petitionInitiators = PetitionInitiator.$search()

    $scope.documentQualities = DocumentQuality.$search()
    $scope.documentQualitiesConfig = {
      create: false,
      valueField: 'id',
      searchField: 'description',
      labelField: 'description',
      placeholder: 'Виберіть зі списку',
      maxItems: 1
    }
]

