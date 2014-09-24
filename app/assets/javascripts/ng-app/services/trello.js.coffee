angular.module('TrelloRelease').service( 'TrelloService', [ '$rootScope', '$location', ($rootScope, $location) ->
  service = {
    boards: [],
    lists: [],
    cards: [],
    token: '',
    selectedBoard: undefined,
    list: undefined,
    getBoards: () ->
      service.boards = []
      Trello.members.get(
        'me',
        (data) ->
          retrieveBoards(data.idBoards, $rootScope);
        (data) ->
          console.log('Failure');
      )
    authorize: () ->
      if Trello.authorized()
        $rootScope.$broadcast('trello.update');
      else
        Trello.authorize({
          type: "popup",
          success: () ->
            service.token = Trello.token();
            $rootScope.$broadcast('trello.update');
          scope: { write: false, read: true }
        });
    getLists: (board) ->
      Trello.get('/boards/' + board.id + '/lists',
        (data) ->
          service.lists = data
          $rootScope.$broadcast('lists.update');
        (data) ->
          console.log 'Failure'
      )
    getCards: (list_id) ->
      Trello.get('/lists/' + list_id + '/cards',
        (data) ->
          service.cards = data
          $rootScope.$broadcast('list.cards.update');
        (data) ->
          console.log 'Failure :('
      )
    getList: (list_id) ->
      Trello.get('/lists/' + list_id,
        (data) ->
          service.list = data
          $rootScope.$broadcast('list.update');
        (data) ->
          console.log 'Failure :('
      )
  }

  retrieveBoards = (idBoards, $rootScope) ->
    $.each(idBoards, (index, value) ->
      Trello.get('/boards/' + value,
        (data) ->
          service.boards.push(data);
          $rootScope.$broadcast('boards.update');
        (data) ->
          console.log('Failure');
      )
    );

   return service;
]);
