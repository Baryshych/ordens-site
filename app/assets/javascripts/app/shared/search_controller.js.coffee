module.controller 'SearchableCtrl', [
  '$scope'
  '$timeout'
  ($scope, $timeout) ->
    searchPromise = false

    $scope.$watch('search',
      (newSearch, oldSearch)->
        if oldSearch != newSearch
          console.log('search triggered')
          $timeout.cancel(searchPromise) if searchPromise
          searchPromise = $timeout(
            ()->
              queryParams['search'] = newSearch
              loadItems(queryParams)
              console.log('timeout ended')
            300
          )
      true
    )

    $scope.$watch('filters',
      (newSet, oldSet)->
        if oldSet != newSet
          console.log('filters triggered')
          queryParams = newSet
          queryParams['search'] = newSearch
          loadItems(queryParams)
          console.log('timeout ended')
      true
    )
]