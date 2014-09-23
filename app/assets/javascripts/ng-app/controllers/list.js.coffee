angular.module('TrelloRelease')
  .controller('ListCtrl', ['$scope', '$routeParams', '$location', 'TrelloService', 'ReleaseService', ($scope, $routeParams, $location, TrelloService, ReleaseService) ->
    $scope.cards = [];

    $scope.$on('list.cards.update', (event) ->
      $scope.cards = TrelloService.cards
      $scope.$apply()
    )
    TrelloService.getCards($routeParams.listId)

    $scope.$on('list.update', (event) ->
      $scope.list = TrelloService.list
      $scope.$apply()
    )
    TrelloService.getList($routeParams.listId)

    $scope.removeCard = (card) ->
      index = $scope.cards.indexOf(card)
      $scope.cards.splice(index, 1);

    $scope.submitRelease = () ->
      ReleaseService.newRelease($scope.cards).then(
        (id) ->
          $location.path('/release/' + id)
        () ->
          console.log 'Fail'
      )
  ]);
