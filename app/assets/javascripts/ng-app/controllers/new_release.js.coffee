angular.module('TrelloRelease')
  .controller('NewReleaseCtrl', ['$scope', '$routeParams', '$location', 'TrelloService', ($scope, $routeParams, $location, TrelloService) ->
    $scope.lists = []

    $scope.$on('lists.update', (event) ->
      $scope.lists = TrelloService.lists
      $scope.$apply()
    )
    if TrelloService.selectedBoard != undefined
      TrelloService.getLists(TrelloService.selectedBoard)
    else
      TrelloService.getBoard($routeParams.boardId)
      $scope.$on('board.get', (e, data) ->
        TrelloService.selectedBoard = data
        TrelloService.getLists(TrelloService.selectedBoard)
    )
  ]);
