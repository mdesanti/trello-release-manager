angular
  .module('TrelloRelease', [
      'ngRoute',
      'templates',
      'restangular',
      'ngSanitize',
      'simpleFormat',
      'truncate'
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
      .when('/release/:releaseId/tagGithubRelease', {
        templateUrl: 'tag_github_release.html'
      })
      .when('/github/auth', {
        templateUrl: 'tag_github_release.html'
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
  ]).factory('GitHubRestangular', ['Restangular', (Restangular) ->
    return Restangular.withConfig (RestangularConfigurer) ->
      RestangularConfigurer.setBaseUrl('https://api.github.com/')

  ]).run(['$rootScope', '$location', 'TrelloService', ($rootScope, $location, TrelloService) ->

    OAuth.initialize('WTEI9Z8BjVIxkR-kolxLNwn_GO8');

    if !Trello.authorized()
      TrelloService.authorize()
  ]);
