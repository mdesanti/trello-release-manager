angular.module('TrelloRelease')
  .controller('BoardsCtrl', ['$scope', '$location', 'TrelloService', ($scope, $location, TrelloService) ->
    $scope.boards = [];

    # login with Trello
    TrelloService.authorize()

    $scope.$on('boards.update', (event) ->
      $scope.boards = TrelloService.boards
      $scope.$apply()
    )
    TrelloService.getBoards()

    $scope.selectBoard = (board) ->
      TrelloService.selectedBoard = board
      $location.path('/choose')
  ]);
