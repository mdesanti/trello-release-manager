angular.module('TrelloRelease')
  .controller('BoardsCtrl', ($scope) ->
    # login with Trello
    $scope.boards = [];
    Trello.authorize({
      name: "Trello Release",
      type: "redirect",
      interactive: true,
      expiration: "never",
      persist: true,
      success: () ->
        $scope.token = Trello.token();
      scope: { write: false, read: true }
    });
    # Get all the boards the user has access to
    Trello.members.get(
      'me',
      (data) ->
        getBoards(data.idBoards, $scope);
      (data) ->
        console.log('Failure');
    )
    $scope.things = ['Angular', 'Rails 4.1', 'Working', 'Together!!'];

    $scope.loadLists = (board) ->
      Trello.get('/boards/' + board.id + '/lists',
        (data) ->
          $scope.lists = data
          $scope.$apply()
        (data) ->
          console.log 'Failure'
      )

    # ------------- Private Functions ------------------
    getBoards = (idBoards, $scope) ->
      $.each(idBoards, (index, value) ->
        Trello.get('/boards/' + value,
          (data) ->
            $scope.boards.push(data);
            $scope.$apply()
          (data) ->
            console.log('Failure');
        )
      );
  );
