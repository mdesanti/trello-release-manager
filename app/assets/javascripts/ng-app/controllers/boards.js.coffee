angular.module('TrelloRelease')
  .controller('BoardsCtrl', ($scope, TrelloService) ->
    $scope.boards = [];

    # login with Trello
    TrelloService.authorize()

    $scope.$on('boards.update', (event) ->
      $scope.boards = TrelloService.boards
      $scope.$apply()
    )
    TrelloService.getBoards()

    $scope.loadLists = (board) ->
      $scope.$on('lists.update', (event) ->
        $scope.lists = TrelloService.lists
        $scope.$apply()
      )
      TrelloService.getLists(board)
  );
