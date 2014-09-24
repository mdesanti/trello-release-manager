angular.module('TrelloRelease')
  .controller('LoginCtrl', ['$scope', '$location', 'TrelloService', ($scope, $location, TrelloService) ->

    $scope.$on('trello.update', (event) ->
      $location.path('/boards')
    )
    # login with Trello
    TrelloService.authorize()

  ]);
