module.controller 'ProfilesCtrl', [
  '$scope'
  '$state'
  'Profile'
  '$stateParams'
  '$timeout'
  'Filter'
  ($scope, $state, Profile, $stateParams, $timeout, Filter) ->

    searchPromise = false

    if $stateParams.page
      $scope.currentPage = $stateParams.page
    else
      $scope.currentPage = 1
    $scope.search = $stateParams.search if $stateParams.search

    queryParams = { page: $scope.currentPage, search: $scope.search }

    loadProfiles =(queryParams)->
      Profile.$search(queryParams).$then (result) ->
        $scope.profiles = result
        $scope.perPage = result.$metadata["per_page"]
        $scope.totalEntries = result.$metadata["total_entries"]

    Filter.search($scope, queryParams, loadProfiles)

    $scope.destroy =(profile)->
      conf = confirm('Ви точно хочете видалити анкету?')
      if conf
        profile.$destroy()
        toastr['success']('Анкету видалено')
        loadProfiles(queryParams)

    $scope.getPage =(pageNumber)->
      $scope.currentPage = pageNumber
      $state.go('profiles', { page: pageNumber, search: $scope.search })

    # $scope.$watch('search',
    #   (newSearch, oldSearch)->
    #     if oldSearch != newSearch
    #       console.log('watch triggered')
    #       $timeout.cancel(searchPromise) if searchPromise
    #       searchPromise = $timeout(
    #         ()->
    #           queryParams['search'] = newSearch
    #           loadProfiles(queryParams)
    #           console.log('timeout ended')
    #         2000
    #       )
    # )

    $scope.orderOptions = [
      { value: 'second_name ASC', name: 'алфавітом А-Я' },
      { value: 'second_name DESC', name: 'алфавітом Я-А' },
      { value: 'created DESC', name: 'датою створення анкети (новіші зверху)' },
      { value: 'created ASC', name: 'датою створення анкети (старіші зверху)' },
      { value: 'comission_date DESC', name: 'датою останнього клопотання (новіші зверху)' },
      { value: 'comission_date ASC', name: 'датою останнього клопотання (старіші зверху)' }
    ]
    $scope.selectedOption = $scope.orderOptions[3]

    $scope.$watch('selectedOption',
      (new_option, old_option) ->
        console.log(new_option)
    )

    loadProfiles(queryParams)
    
    $("select").dropdown();
]

