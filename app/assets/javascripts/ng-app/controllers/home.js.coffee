angular.module('TrelloRelease')
  .controller('HomeCtrl', ['$scope', '$location', 'TrelloService', ($scope, $location, TrelloService) ->
    $scope.selectedBoard = TrelloService.selectedBoard
  ]);
