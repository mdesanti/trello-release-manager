angular.module('TrelloRelease')
  .controller('ListCtrl', ['$scope', '$routeParams', '$location', 'TrelloService', 'ReleaseService', ($scope, $routeParams, $location, TrelloService, ReleaseService) ->
    $scope.trello_release = {
      release_date: new Date(),
      board: TrelloService.selectedBoard.id,
      trello_cards_attributes: []
    }

    $scope.$on('list.cards.update', (event) ->
      addCards(TrelloService.cards)
      $scope.$apply()
    )
    TrelloService.getCards($routeParams.listId)

    $scope.$on('list.update', (event) ->
      $scope.list = TrelloService.list
      $scope.$apply()
    )
    TrelloService.getList($routeParams.listId)

    $scope.removeCard = (card) ->
      index = $scope.trello_release.trello_cards_attributes.indexOf(card)
      $scope.trello_release.trello_cards_attributes.splice(index, 1);

    $scope.submitRelease = () ->
      ReleaseService.newRelease($scope.trello_release).then(
        (id) ->
          $location.path('/release/' + id)
        () ->
          console.log 'Fail'
      )

    addCards = (cards) ->
      angular.forEach(cards, (card, index) ->
        $scope.trello_release.trello_cards_attributes.push({card_number: card.idShort, card_link: card.url, card_name: card.name})
      )
  ]);
