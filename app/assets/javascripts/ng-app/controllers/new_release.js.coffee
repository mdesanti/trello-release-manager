angular.module('TrelloRelease')
  .controller('NewReleaseCtrl', ['$scope', '$location', 'TrelloService', ($scope, $location, TrelloService) ->
    $scope.lists = []

    $scope.$on('lists.update', (event) ->
      $scope.lists = TrelloService.lists
      $scope.$apply()
    )
    TrelloService.getLists(TrelloService.selectedBoard)

  ]);
