angular
    .module('TrelloRelease', [
        'ngRoute',
        'templates',
        'restangular'
    ]).config(['$routeProvider', '$locationProvider', 'RestangularProvider',($routeProvider, $locationProvider, RestangularProvider) ->
        RestangularProvider.setBaseUrl('/');
        $routeProvider
          .when('/', {
            templateUrl: 'home.html'
          })
          .when('/lists/:listId', {
            templateUrl: 'list.html'
          })
          .when('/release/:releaseId', {
            templateUrl: 'release.html'
          });
        $locationProvider.html5Mode(true);
    ]);
