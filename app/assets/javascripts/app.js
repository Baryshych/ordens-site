var module = angular.module('orden', [
  'ui.router',
  'ngResource',
  'restmod',
  'willPaginate',
  'ui.bootstrap',
  'ngAnimate',
  'flock.bootstrap.material',
  'angularUtils.directives.dirPagination',
  'selectize'
])

module.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

module.config(function(restmodProvider) {
    restmodProvider.rebase('DefaultPacker');
});

module.config(['restmodProvider', function(restmodProvider) {
  restmodProvider.rebase({
    $config: {
      style: 'NoStyle'
    }
  });
}]);