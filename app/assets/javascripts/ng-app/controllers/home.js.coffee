angular.module('TrelloRelease')
  .controller('HomeCtrl', ['$scope', '$location', 'TrelloService', ($scope, $location, TrelloService) ->
    $scope.selectedBoard = TrelloService.selectedBoard
    if $scope.selectedBoard == undefined
      $location.path('/')
  ]);
