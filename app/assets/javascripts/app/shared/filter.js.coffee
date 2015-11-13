module.factory('Filter', ['$timeout', ($timeout) ->
  Filter =->
    console.log('Filter init')
  Filter.prototype.search =($scope, queryParams, loadItems)->
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
            1500
          )
      true
    )
  Filter.prototype.watch =($scope, queryParams, loadItems)->
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
  return new Filter
])