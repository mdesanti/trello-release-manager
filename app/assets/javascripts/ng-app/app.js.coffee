angular
  .module('TrelloRelease', [
      'ngRoute',
      'templates',
      'restangular',
      'ngSanitize',
      'simpleFormat'
  ]).config(['$routeProvider', '$locationProvider', 'RestangularProvider', ($routeProvider, $locationProvider, RestangularProvider) ->
    RestangularProvider.setBaseUrl('/');

    $routeProvider
      .when('/', {
        controller: 'LoginCtrl',
        templateUrl: 'login.html'
      })
      .when('/boards', {
        templateUrl: 'home.html'
      })
      .when('/lists/:listId/cards', {
        templateUrl: 'cards.html'
      })
      .when('/release/:releaseId', {
        templateUrl: 'release.html'
      })
      .when('/choose', {
        templateUrl: 'choose.html'
      })
      .when('/board/:boardId/selectList', {
        templateUrl: 'new_release.html'
      })
      .when('/board/:boardId/releases', {
        templateUrl: 'list_releases.html'
      });
    $locationProvider.html5Mode(true);
  ]).run(['$rootScope', '$location', ($rootScope, $location) ->
    if !Trello.authorized() && $location.path() != '/'
      $location.path('/')
  ]);
