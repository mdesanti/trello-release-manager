angular
    .module('TrelloRelease', [
        'ngRoute',
        'templates'
    ]).config(($routeProvider, $locationProvider) ->
        $routeProvider
            .when('/', {
                templateUrl: 'home.html',
                controller: 'BoardsCtrl'
            });
        $locationProvider.html5Mode(true);
    );
